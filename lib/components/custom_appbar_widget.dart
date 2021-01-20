import 'package:covid19_app/core/flutter_icons.dart';
import 'package:covid19_app/pages/user_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:covid19_app/components/avatar.dart';


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
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserProfilePage()),
            );
          },
          child: Avatar(width: 50, height: 50,),
        )
      ],
    );
  }
}


