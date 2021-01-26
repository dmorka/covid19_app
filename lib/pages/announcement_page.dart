import 'package:covid19_app/components/menu.dart';
import 'package:covid19_app/components/protected_container.dart';
import 'package:flutter/material.dart';
import 'package:covid19_app/core/consts.dart';
import 'package:covid19_app/components/custom_appbar_widget.dart';
import 'package:covid19_app/utils/services/firestore_service.dart';
import 'package:covid19_app/components/announcement_data_widget.dart';
import 'package:covid19_app/models/annoucement.dart';
import 'package:covid19_app/components/rounded_button.dart';
import 'package:provider/provider.dart';
import 'announcements_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AnnouncementPage extends StatefulWidget {
  const AnnouncementPage({Key key, this.announcement}) : super(key: key);

  final Annoucement announcement;

  @override
  State<StatefulWidget> createState() => _AnnouncementPage(announcement);
}

class _AnnouncementPage extends State<AnnouncementPage> {
  Annoucement _announcement;

  _AnnouncementPage(Annoucement announcement) {
    _announcement = announcement;
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
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RoundedButton(
                        text: "Zgłoś chęć realizacji ogłoszenia",
                        textAlign: TextAlign.center,
                        color: Colors.blue,
                        press: () {
                          FirebaseFirestoreService().addVolunteer(_announcement.id, context.read<User>().uid);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => new AnnouncementsPage()));
                        },
                        padding: EdgeInsets.all(20),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
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
