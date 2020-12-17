import 'package:covid19_app/components/custom_appbar_widget.dart';
import 'package:covid19_app/components/menu.dart';
import 'package:covid19_app/components/protected_container.dart';
import 'package:covid19_app/components/rounded_button.dart';
import 'package:covid19_app/core/consts.dart';
import 'package:covid19_app/core/flutter_icons.dart';
import 'package:covid19_app/pages/user_personal_info_edit_page.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ProtectedContainer(
      body: Scaffold(
        // resizeToAvoidBottomPadding: false,
        backgroundColor: backgroundColor,
        drawer: MenuDrawer(),
        body: Builder( builder: (context) =>
        SingleChildScrollView(
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
                  text: "Lista Aktywnych ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.black87,
                  ),
                  children: [
                    TextSpan(
                      text: "Zamówień:",
                      style: TextStyle(
                        color: mainColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
        ),
      ),
    );
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
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5),
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/profile.jpg"))),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .5,
                  child: Text(
                    "Jan Kowalski",
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                _buildUserPersonalDataItem(Icons.phone, "023 622 523"),
                SizedBox(height: 5),
                _buildUserPersonalDataItem(
                    Icons.email_outlined, "jkowalski@example.com"),
                SizedBox(height: 5),
                _buildUserPersonalDataItem(Icons.location_pin,
                    "ul. Kościelna 67 m.106, 00-001 Warszawa"),
              ],
            ),
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
