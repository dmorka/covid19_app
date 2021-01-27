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

  @override
  Widget build(BuildContext context) {
    FirebaseFirestoreService()
        .getAnnoucements("id", widget.announcementId)
        .then((value) {
      setState(() {
        _announcement = value[0];
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RoundedButton(
                            text: "Zrezygnuj z chęci pomocy",
                            textAlign: TextAlign.center,
                            color: Colors.red,
                            press: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => _createAlertDialog());
                            },
                            padding: EdgeInsets.all(20),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
              : Column(),
            ],
          ),
        ),
      ),
    );
  }

  AlertDialog _createAlertDialog() {
    return AlertDialog(
      title: Text("Potwierdzenie rezygnacji"),
      content: Text("Czy na pewno chcesz zrezygnować z chęci realizacji tego ogłoszenia?"),
      actions: [
        FlatButton(
          child: Text("Tak, rezygnuję"),
          onPressed: () {
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
      ],
    )
    : Column();
  }
}
