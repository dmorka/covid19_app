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
import 'package:covid19_app/components/content_header.dart';

class UsersCreatedAnnouncementPage extends StatefulWidget {
  const UsersCreatedAnnouncementPage({Key key, this.announcement}) : super(key: key);

  final Annoucement announcement;

  @override
  _UsersCreatedAnnouncementPageState createState() => _UsersCreatedAnnouncementPageState(announcement);
}

class _UsersCreatedAnnouncementPageState extends State<UsersCreatedAnnouncementPage> {
  Annoucement _announcement;

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
              ContentHeader(name: "Chętni wolontariusze"),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: _buildVolunteersList(),
              ),
              SizedBox(height: 10),
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

  Widget _buildVolunteersList() {
    // temporary list
    return Column(
      children: [
        EagerVolunteersListItem("Anna", 10, 1),
        EagerVolunteersListItem("Tomek", 55, 9),
        EagerVolunteersListItem("Artur", 2, 1000),
        EagerVolunteersListItem("Patryk", 30, 10),
      ],
    );
    /*return FutureBuilder<List<Annoucement>>(
        future: FirebaseFirestoreService()
            .getAnnoucements("userId", context.read<User>().uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? ListView.builder(
              shrinkWrap: true,
              controller: controller,
              itemCount: snapshot.data.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return UsersCreatedAnnouncementsListItem(snapshot.data[index]);
              })
              : Column();
        });*/
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
