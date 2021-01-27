import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid19_app/models/annoucement.dart';
import 'package:covid19_app/components/menu.dart';
import 'package:covid19_app/components/protected_container.dart';
import 'package:covid19_app/core/consts.dart';
import 'package:covid19_app/components/announcement_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:covid19_app/components/rounded_button.dart';
import 'package:covid19_app/components/custom_appbar_widget.dart';
import 'package:covid19_app/components/eager_volunteers_list_item.dart';
import 'package:covid19_app/utils/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:covid19_app/models/volunteer.dart';
import 'package:covid19_app/components/content_header.dart';

class UsersCreatedAnnouncementPage extends StatefulWidget {
  const UsersCreatedAnnouncementPage({Key key, this.announcement})
      : super(key: key);

  final Annoucement announcement;

  @override
  _UsersCreatedAnnouncementPageState createState() =>
      _UsersCreatedAnnouncementPageState(announcement);
}

class _UsersCreatedAnnouncementPageState
    extends State<UsersCreatedAnnouncementPage> {
  Annoucement _announcement;
  ScrollController controller = ScrollController();
  _UsersCreatedAnnouncementPageState(Annoucement annoucement) {
    _announcement = annoucement;
  }

  @override
  Widget build(BuildContext context) {
    return ProtectedContainer(
      body: Scaffold(
        // resizeToAvoidBottomPadding: false,
        backgroundColor: backgroundColor,
        drawer: MenuDrawer(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                padding: EdgeInsets.only(top: 25),
                child: Stack(
                  children: <Widget>[
                    Image.asset("assets/images/virus2.png"),
                    _buildHeader(),
                  ],
                ),
              ),
              SizedBox(height: 10),
              AnnouncementDataWidget(_announcement),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: ContentHeader(name: "Chętni wolontariusze"),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: FutureBuilder<List<VolunteerModel>>(
                  future: FirebaseFirestoreService().getVolunteers(
                      _announcement.volunteers),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);

                    return snapshot.data.length != 0
                        ? _buildVolunteersList(snapshot.data)
                        :Column(children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text("Brak zgłoszeń."),
                      ),
                    ],);
                  },
                  // _buildVolunteersList(),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RoundedButton(
                        text: "Usuń to ogłoszenie",
                        textAlign: TextAlign.center,
                        color: Colors.red,
                        press: () {
                          showDialog(
                            context: context,
                            builder: (_) => _createAlertDialog()
                          );
                        },
                        padding: EdgeInsets.all(20),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AlertDialog _createAlertDialog() {
    return AlertDialog(
      title: Text("Potwierdzenie usunięcia ogłoszenia"),
      content: Text("Czy na pewno chcesz usunąć bezpowrotnie to ogłoszenie?"),
      actions: [
        FlatButton(
          child: Text("Tak, usuń"),
          onPressed: () {
            FirebaseFirestoreService()
                .deleteAnnoucement(_announcement.id)
                .then((value) =>
                Navigator.of(context).popUntil(ModalRoute.withName('/user-profile')));
          },
        ),
        FlatButton(
          child: Text("Nie"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  Widget _buildVolunteersList(volunteers) {
    return ListView.builder(
        shrinkWrap: true,
        controller: controller,
        itemCount: volunteers.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              EagerVolunteersListItem(volunteers[index]),
            ],

          );
        }
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomAppBarWidget(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            _announcement.title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
        ),
      ],
    );
  }
}
