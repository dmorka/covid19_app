import 'package:covid19_app/core/consts.dart';
import 'package:flutter/material.dart';
import 'package:covid19_app/pages/home_page.dart';
import 'package:covid19_app/pages/labs_page.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              "MENU",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),
            ),
            decoration: BoxDecoration(
              color: mainColor,
              image: DecorationImage(
                  image: AssetImage("assets/images/virus2.png"),
                  fit: BoxFit.cover),
            ),
          ),
          ListTile(
            title: Text(
              'Strona główna',
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (_) => HomePage()
                  )
              );
            },
          ),
          ListTile(
            title: Text('Laboratoria COVID'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => LabsPage()
                )
              );
            },
          ),
        ],
      ),
    );
  }
}
