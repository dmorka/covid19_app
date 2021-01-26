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

                    return snapshot.hasData
                        ? _buildVolunteersList(snapshot.data) : Column();
                  },
                  // _buildVolunteersList(),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RoundedButton(
                        text: "Usuń",
                        textAlign: TextAlign.center,
                        color: Colors.blue,
                        /*press: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AnnouncementsPage()));
                        },*/
                        padding: EdgeInsets.all(20),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: RoundedButton(
                        text: "Usuń",
                        textAlign: TextAlign.center,
                        color: Colors.blue,
                        /*press: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AnnouncementsPage()));
                        },*/
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
