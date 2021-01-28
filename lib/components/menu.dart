import 'package:covid19_app/core/consts.dart';
import 'package:covid19_app/pages/intro_page.dart';
import 'package:covid19_app/pages/labs_page.dart';
import 'package:covid19_app/pages/statistics_page.dart';
import 'package:covid19_app/utils/services/authentication_provider.dart';
import 'package:covid19_app/utils/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:covid19_app/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:covid19_app/pages/important_info_page.dart';

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
          Container(
            height: 70,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: mainColor,
                image: DecorationImage(
                  image: AssetImage("assets/images/virus2.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Strona główna',
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => HomePage()));
            },
          ),
          ListTile(
            trailing: Icon(
              Icons.warning,
              color: Colors.orange,
            ),
            title: Text('Ważne informacje'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => ImportantInfoPage()));
            },
          ),
          ListTile(
            title: Text('Statystki'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => StatisticPage()));
            },
          ),
          ListTile(
            title: Text('Laboratoria COVID'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => LabsPage()));
            },
          ),
          ListTile(
            trailing: Icon(Icons.logout),
            title: Text('Wyloguj'),
            onTap: () async {
              await FirebaseFirestoreService().removeDeviceToken();
              context.read<AuthenticationProvider>().signOut();
              Navigator.of(context).popUntil(ModalRoute.withName('/'));
            },
          ),
        ],
      ),
    );
  }
}
