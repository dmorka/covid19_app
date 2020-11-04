import 'package:covid19_app/core/flutter_icons.dart';
import 'package:covid19_app/pages/user_profile_page.dart';
import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Icon(
            FlutterIcons.menu,
            color: Colors.white,
          ),
          onPressed: null,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserProfilePage()),
            );
          },
          child: Container(
            width: 50,
            height: 50,
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
                image: DecorationImage(
                    image: AssetImage("assets/images/profile.jpg"))),
          ),
        )
      ],
    );
  }
}
