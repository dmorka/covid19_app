import 'dart:async';
import 'dart:io';

import 'package:covid19_app/components/annoucment_dialog.dart';
import 'package:covid19_app/components/custom_appbar_widget.dart';
import 'package:covid19_app/components/menu.dart';
import 'package:covid19_app/components/protected_container.dart';
import 'package:covid19_app/components/rounded_button.dart';
import 'package:covid19_app/core/consts.dart';
import 'package:covid19_app/models/statistics.dart';
import 'package:covid19_app/pages/statistics_page.dart';
import 'package:covid19_app/utils/services/firestore_service.dart';
import 'package:covid19_app/utils/services/rest_api_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'announcements_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GeneralStatisticsModel _generalStatisticsModel =
      GeneralStatisticsModel(cases: 0, deaths: 0, recovered: 0);

  DateTime lastBackPressTime;

  _HomePageState() {
    ApiDataProvider().fetchGeneralStatistics().then((val) => setState(() {
          _generalStatisticsModel = val;
        }));
  }

  final FirebaseMessaging _fcm = FirebaseMessaging();

  StreamSubscription iosSubscription;

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
        print(data);
        _saveDeviceToken();
      });

      _fcm.requestNotificationPermissions(IosNotificationSettings());
    } else {
      _saveDeviceToken();
    }

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                color: mainColor,
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // TODO open the page of the announcement to which the notification refers
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // TODO open the page of the announcement to which the notification refers
      },
    );
  }

  @override
  void dispose() {
    if (iosSubscription != null) iosSubscription.cancel();
    super.dispose();
  }

  /// Get the token, save it to the database for current user
  _saveDeviceToken() async {
    // Get the current user
    User user = FirebaseAuth.instance.currentUser;

    // Get the token for this device
    String fcmToken = await _fcm.getToken();

    // Save it to Firestore
    if (user != null && fcmToken != null) {
      FirebaseFirestoreService().addDeviceToken(user.uid, fcmToken);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: ProtectedContainer(
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
                      text: "Objawy ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.black87,
                      ),
                      children: [
                        TextSpan(
                          text: "COVID 19",
                          style: TextStyle(
                            color: mainColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(left: 16),
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      _buildSymptomItem("assets/images/1.png", "Gorączka"),
                      _buildSymptomItem("assets/images/2.png", "Suchy kaszel"),
                      _buildSymptomItem("assets/images/3.png", "Ból głowy"),
                      _buildSymptomItem("assets/images/4.png", "Brak tchu"),
                      _buildSymptomItem(
                          "assets/images/5.png", "Brak smaku\ni węchu"),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Zapobieganie",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(left: 16),
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      _buildPrevention(
                          "assets/images/a10.png", "MYJ", "często ręce", 160),
                      _buildPrevention("assets/images/a4.png", "ZAKRYWAJ",
                          "buzie gdy kaszlesz", 190),
                      _buildPrevention("assets/images/a6.png", "CZYŚĆ",
                          "często używane\npowierzchnie", 200),
                      _buildPrevention(
                          "assets/images/a8.png", "UTRZYMUJ", "odstęp", 180),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => new StatisticPage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      border: Border.all(color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(1, 1),
                          spreadRadius: 1,
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset("assets/images/poland_map.png"),
                        SizedBox(width: 25),
                        RichText(
                          text: TextSpan(
                            text: "STATYSTYKI\n",
                            style: TextStyle(
                              color: mainColor,
                              fontWeight: FontWeight.bold,
                              height: 1.3,
                            ),
                            children: [
                              TextSpan(
                                text: "Przegląd Polski\n",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              TextSpan(
                                text: numFormatter
                                        .format(_generalStatisticsModel.cases) +
                                    " potwierdzonych",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 10,
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        IconButton(
                          icon: Icon(Icons.arrow_forward_ios),
                          onPressed: null,
                        ),
                      ],
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPrevention(
      String path, String text1, String text2, double width) {
    return Column(
      children: <Widget>[
        Container(
          width: width,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            border: Border.all(color: Colors.white),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(1, 1),
                spreadRadius: 1,
                blurRadius: 1,
              ),
            ],
          ),
          padding: EdgeInsets.all(12),
          child: Row(
            children: <Widget>[
              Image.asset(path),
              SizedBox(width: 10),
              RichText(
                text: TextSpan(
                  text: "$text1\n",
                  style: TextStyle(
                    color: mainColor,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: text2,
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          margin: EdgeInsets.only(right: 20),
        ),
        SizedBox(height: 7),
      ],
    );
  }

  Widget _buildSymptomItem(String path, String text) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              gradient: LinearGradient(
                colors: [
                  Colors.purple.withOpacity(.01),
                  Colors.white,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              border: Border.all(color: Colors.white),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(1, 1),
                  spreadRadius: 1,
                  blurRadius: 3,
                )
              ],
            ),
            padding: EdgeInsets.only(top: 15),
            child: Image.asset(path),
          ),
          SizedBox(height: 7),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      margin: EdgeInsets.only(right: 20),
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
            "COVID 19",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "System wzajemnej pomocy",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 25),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Ta aplikacja została stworzona, aby pomóc osobom cierpiącym "
            "koronawirusa, możesz dodać własne ogłoszenie, aby uzyskać pomoc, której możesz potrzebować.",
            style: TextStyle(
              color: Colors.white,
              height: 1.3,
            ),
          ),
        ),
        SizedBox(height: 25),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: RoundedButton(
                text: "DODAJ\nOGŁOSZENIE",
                textAlign: TextAlign.center,
                color: Colors.blue,
                press: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AnnouncementDialog();
                      });
                },
                padding: EdgeInsets.all(20),
              )),
              SizedBox(width: 16),
              Expanded(
                child: RoundedButton(
                  text: "PRZEGLĄDAJ OGŁOSZENIA",
                  textAlign: TextAlign.center,
                  color: Colors.blue,
                  press: () {
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
    );
  }

  Future<bool> _onWillPop() {
    DateTime now = DateTime.now();
    if (lastBackPressTime == null ||
        now.difference(lastBackPressTime) > Duration(seconds: 2)) {
      lastBackPressTime = now;
      Fluttertoast.showToast(msg: "Wciśnij ponownie, aby wyjść z aplikacji.");
      return Future.value(false);
    }
    SystemNavigator.pop();
    return Future.value(true);
  }
}
