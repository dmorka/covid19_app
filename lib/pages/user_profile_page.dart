import 'package:covid19_app/components/menu.dart';
import 'package:covid19_app/components/protected_container.dart';
import 'package:covid19_app/components/rounded_button.dart';
import 'package:covid19_app/core/consts.dart';
import 'package:covid19_app/core/flutter_icons.dart';
import 'package:covid19_app/models/user.dart';
import 'package:covid19_app/pages/user_personal_info_edit_page.dart';
import 'package:covid19_app/utils/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:covid19_app/models/annoucement.dart';
import 'package:covid19_app/utils/services/firestore_service.dart';
import 'package:covid19_app/components/announcements_list_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfilePage> {

  List<Annoucement> announcementsList;
  ScrollController controller = ScrollController();

  void getPostsData(String uid) {
    FirebaseFirestoreService()
        .getAnnoucements("userId", uid)
        .then((value) {
          if (!mounted){
            setState(() {
              announcementsList = value;
            });
          }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getPostsData(context.watch<User>().uid);

    return ProtectedContainer(
      body: Scaffold(
        // resizeToAvoidBottomPadding: false,
        backgroundColor: backgroundColor,
        drawer: MenuDrawer(),
        body: Builder(
          builder: (context) => SingleChildScrollView(
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
                  padding: EdgeInsets.only(top: 25, bottom: 30),
                  child: Stack(
                    children: <Widget>[
                      Image.asset("assets/images/virus2.png"),
                      _buildHeader(context),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: RichText(
                    text: TextSpan(
                      text: "Lista Wystawionych ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.black87,
                      ),
                      children: [
                        TextSpan(
                          text: "Ogłoszeń:",
                          style: TextStyle(
                            color: mainColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: _buildAnnouncements(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnnouncements() {
    if (announcementsList == null || announcementsList.isEmpty) {
      return Column();
    }
    else {
      return ListView.builder(
          shrinkWrap: true,
          controller: controller,
          itemCount: announcementsList.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return AnnouncementsListItem(announcementsList[index]);
          });
    }
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(
                FlutterIcons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            Container(
              // alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(top: 10, right: 10, bottom: 15),
              child: RoundedButton(
                text: "Edytuj",
                color: Colors.white30,
                size: const Size(80, 30),
                padding: null,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserPersonalInfoEditPage()),
                  );
                },
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(16),
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5),
                  borderRadius: BorderRadius.all(
                    Radius.circular(70),
                  ),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/profile.jpg"))),
            ),
            FutureBuilder<UserModel>(
                future: FirebaseFirestoreService().getUser(context.watch<User>().uid),
                builder: (context, snapshot) {
                  // if (snapshot.hasError) print(snapshot.error);

                  return snapshot.hasData
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * .5,
                              child: Text(
                                snapshot.data.getName(),
                                style: TextStyle(
                                  fontSize: 32,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            _buildUserPersonalDataItem(
                                Icons.phone, snapshot.data.phoneNumber),
                            SizedBox(height: 5),
                            _buildUserPersonalDataItem(
                                Icons.email_outlined, context.watch<User>().email),
                            SizedBox(height: 5),
                            _buildUserPersonalDataItem(Icons.location_pin,
                                snapshot.data.getAddress()),
                          ],
                        )
                      : Column();
                })
          ],
        ),
      ],
    );
  }

  Widget _buildUserPersonalDataItem(IconData icon, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.white30,
        ),
        SizedBox(width: 5),
        Container(
          width: MediaQuery.of(context).size.width * .5,
          child: Text(
            value,
            style: TextStyle(
                color: Color.fromRGBO(240, 240, 240, 1), fontSize: 16),
          ),
        ),
      ],
    );
  }
}
