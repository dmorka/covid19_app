import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid19_app/components/text_field_container.dart';
import 'package:covid19_app/models/annoucement.dart';
import 'package:covid19_app/components/menu.dart';
import 'package:covid19_app/components/protected_container.dart';
import 'package:covid19_app/core/consts.dart';
import 'package:covid19_app/components/announcement_data_widget.dart';
import 'package:covid19_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:covid19_app/components/rounded_button.dart';
import 'package:covid19_app/components/custom_appbar_widget.dart';
import 'package:covid19_app/components/eager_volunteers_list_item.dart';
import 'package:covid19_app/utils/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:covid19_app/models/volunteer.dart';
import 'package:covid19_app/components/content_header.dart';
import 'package:covid19_app/components/contact_info.dart';

class UsersCreatedAnnouncementPage extends StatefulWidget {
  final String announcementId;

  const UsersCreatedAnnouncementPage({Key key, this.announcementId})
      : super(key: key);


  @override
  _UsersCreatedAnnouncementPageState createState() =>
      _UsersCreatedAnnouncementPageState();
}

class _UsersCreatedAnnouncementPageState
    extends State<UsersCreatedAnnouncementPage> {
  Annoucement _announcement;
  ScrollController controller = ScrollController();
  UserModel deliveringVolunteer;

  @override
  Widget build(BuildContext context) {
    FirebaseFirestoreService()
      .getAnnoucements("id", widget.announcementId)
      .then((value) {
        setState(() {
          _announcement = value[0];
        });

        if (_announcement.confirmed) {
          FirebaseFirestoreService()
              .getUser(_announcement.volunteers[0])
              .then((value) {
            setState(() {
              deliveringVolunteer = value;
            });
          });
        }
    });

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
              _announcement != null
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnnouncementDataWidget(_announcement),
                  SizedBox(height: 10),
                  _announcement.confirmed && deliveringVolunteer != null
                      ? _announcement.received
                        ? _buildReceivedAnnouncement()
                        : _buildConfirmedAnnouncement()
                      : _buildNotConfirmedAnnouncement()
                ],
              )
              : Column(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReceivedAnnouncement() {
    return Column(children: [
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Text("Otrzymane"))
    ]);
  }

  Widget _buildConfirmedAnnouncement() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ContentHeader(name: "Dane wolontariusza"),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ContactInfo(deliveringVolunteer),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Row(
            children: <Widget>[
              Expanded(
                child: RoundedButton(
                  text: "Oznacz zlecenie jako zrealizowane",
                  textAlign: TextAlign.center,
                  color: Colors.green,
                  press: () {
                    showDialog(
                        context: context,
                        builder: (_) => _createAlertDialogOnReceived());
                  },
                  padding: EdgeInsets.all(20),
                ),
              ),
              SizedBox(width: 10,),
              _createCancelButton(),
            ],
          ),
        )
      ],
    );
  }

  Widget _createCancelButton() {
    return Expanded(
      child: RoundedButton(
        text: "Anuluj zlecenie",
        textAlign: TextAlign.center,
        color: Colors.red,
        press: () {
          showDialog(
              context: context,
              builder: (_) => _createAlertDialogOnCancel());
        },
        padding: EdgeInsets.all(20),
      ),
    );
  }

  Widget _buildNotConfirmedAnnouncement() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ContentHeader(name: "Chętni wolontariusze"),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: FutureBuilder<List<VolunteerModel>>(
            future: FirebaseFirestoreService()
                .getVolunteers(_announcement.volunteers),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);

              return snapshot.hasData
                  ? _buildVolunteersList(snapshot.data)
                  : Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text("Brak zgłoszeń."),
                  ),
                ],
              );
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
                        builder: (_) => _createAlertDialogOnDelete());
                  },
                  padding: EdgeInsets.all(20),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  AlertDialog _createAlertDialogOnCancel() {
    return AlertDialog(
      title: Text("Potwierdzenie anulowania zlecenia"),
      content: Text("Czy na pewno chcesz anulować to zlecenie?\n"
          "Spowoduje to brak możliwości wystawienia oceny wolontariuszowi. "
          "Jeżeli nie jesteś zadowolony z usług wolontariusza możesz zakończyć zlecenie, "
          "a następnie wystawić mu negatywną opinie."),
      actions: [
        FlatButton(
          child: Text("Tak, anuluj"),
          onPressed: () {
            Annoucement annoucement = _announcement.clone();
            annoucement.confirmed = false;
            annoucement.volunteers = [];
            print(annoucement.toString());
            FirebaseFirestoreService()
                .updateAnnoucement(annoucement)
                .then((value) {
                  setState(() {
                    _announcement = annoucement;
                  });
            });

            /*Navigator.of(context)
                .popUntil(ModalRoute.withName('/user-profile'));*/
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text("Nie, pozostaw zlecenie"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  AlertDialog _createAlertDialogOnDelete() {
    return AlertDialog(
      title: Text("Potwierdzenie usunięcia ogłoszenia"),
      content: Text("Czy na pewno chcesz usunąć bezpowrotnie to ogłoszenie?"),
      actions: [
        FlatButton(
          child: Text("Tak, usuń"),
          onPressed: () {
            FirebaseFirestoreService().deleteAnnoucement(_announcement.id).then(
                (value) => Navigator.of(context)
                    .popUntil(ModalRoute.withName('/user-profile')));
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

  AlertDialog _createAlertDialogOnReceived() {
    return AlertDialog(
      title: Text("Potwierdzenie otrzymania zlecenia"),
      content: Text("Czy na pewno chcesz oznaczyć zlecenie jako otrzymane?"),
      actions: [
        FlatButton(
          child: Text("Tak, otrzymałem"),
          onPressed: () {
            setState(() {
              _announcement.received = true;
            });
            FirebaseFirestoreService()
                .updateAnnoucement(_announcement)
                .then((value) => Navigator.of(context)
                    .popUntil(ModalRoute.withName('/user-profile')));
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
              EagerVolunteersListItem(volunteers[index], _announcement),
            ],
          );
        });
  }

  Widget _buildHeader() {
    return _announcement != null
      ? Column(
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
        _announcement.confirmed && deliveringVolunteer != null
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Text(
                  "Wolontariusz:",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 24,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  deliveringVolunteer.firstName + ' ' + deliveringVolunteer.lastName,
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 20
                  ),
                )
              ],
            ),
          )
        : Column()
      ],
    )
    : Column();
  }
}
