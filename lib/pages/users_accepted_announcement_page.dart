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
import 'package:covid19_app/models/user.dart';
import 'package:covid19_app/components/contact_info.dart';

class UsersAcceptedAnnouncementPage extends StatefulWidget {
  const UsersAcceptedAnnouncementPage({Key key, this.announcementId})
      : super(key: key);

  final String announcementId;

  @override
  _UsersAcceptedAnnouncementPageState createState() =>
      _UsersAcceptedAnnouncementPageState();
}

class _UsersAcceptedAnnouncementPageState
    extends State<UsersAcceptedAnnouncementPage> {
  Annoucement _announcement;
  ScrollController controller = ScrollController();
  UserModel orderer;

  @override
  Widget build(BuildContext context) {
    FirebaseFirestoreService()
        .getAnnoucements("id", widget.announcementId)
        .then((value) {
      setState(() {
        _announcement = value[0];

        if (_announcement.confirmed) {
          FirebaseFirestoreService()
              .getUser(_announcement.userId)
              .then((value) {
            setState(() {
              orderer = value;
            });
          });
        }
      });
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
                children: [
                  AnnouncementDataWidget(_announcement),
                  SizedBox(height: 10),
                  _announcement.confirmed
                  ? Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: ContentHeader(name: "Dane zleceniodawcy"),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: orderer != null
                        ? ContactInfo(orderer)
                        : Column(),
                      ),
                      _announcement.delivered
                      ? _buildDeliveredAnnouncement()
                      : _buildNotDeliveredAnnouncement()
                    ],
                  )
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

  Widget _buildDeliveredAnnouncement() {
    return Column(children: [
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Text("Dostarczone"))
    ]);
  }

  Widget _buildNotDeliveredAnnouncement() {
    return Column(
      children: [
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
                        builder: (_) => _createAlertDialogOnDelivered());
                  },
                  padding: EdgeInsets.all(20),
                ),
              ),
              SizedBox(width: 10,),
              _createDeclineButton(),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildNotConfirmedAnnouncement() {
    return Column(children: [
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: _createDeclineButton())
    ]);
  }

  Widget _createDeclineButton() {
    return Expanded(
      child: RoundedButton(
        text: "Zrezygnuj z chęci pomocy",
        textAlign: TextAlign.center,
        color: Colors.red,
        press: () {
          showDialog(
              context: context,
              builder: (_) => _createAlertDialogOnDecline());
        },
        padding: EdgeInsets.all(20),
      ),
    );
  }

  AlertDialog _createAlertDialogOnDecline() {
    return AlertDialog(
      title: Text("Potwierdzenie rezygnacji"),
      content: Text("Czy na pewno chcesz zrezygnować z chęci realizacji tego ogłoszenia?"),
      actions: [
        FlatButton(
          child: Text("Tak, rezygnuję"),
          onPressed: () {
            setState(() {
              _announcement.confirmed = false;
              _announcement.volunteers = [];
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

  AlertDialog _createAlertDialogOnDelivered() {
    return AlertDialog(
      title: Text("Potwierdzenie dostarczenia"),
      content: Text("Czy na pewno chcesz oznaczyć zlecenie jako dostarczone?"),
      actions: [
        FlatButton(
          child: Text("Tak, dostarczyłem zlecenie"),
          onPressed: () {
            setState(() {
              _announcement.delivered = true;
            });
            FirebaseFirestoreService()
              .updateAnnoucement(_announcement);
            Navigator.of(context)
                .popUntil(ModalRoute.withName('/user-profile'));
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Text(
                "Dla kogo:",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 24,
                ),
              ),
              SizedBox(width: 10),
              FutureBuilder(
                future: FirebaseFirestoreService().getUser(_announcement.userId),
                builder: (context, snapshot) {
                  return snapshot.hasData
                  ? Text(
                    snapshot.data.firstName + ' ' + snapshot.data.lastName,
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 20
                    ),
                  )
                  : Column();
                },
              )

            ],
          ),
        )
      ],
    )
    : Column();
  }
}
