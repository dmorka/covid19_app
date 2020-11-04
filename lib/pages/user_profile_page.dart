import 'package:covid19_app/core/consts.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
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
                _buildHeader(),
              ],
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: RichText(
              text: TextSpan(
                text: "List of ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black87,
                ),
                children: [
                  TextSpan(
                    text: "Active Orders:",
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
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 50),
        Row(
          children: [
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
                    "Dawid Morka",
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
                    Icons.email_outlined, "dmorka@example.com"),
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
