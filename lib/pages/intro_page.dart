import 'package:covid19_app/components/rounded_button.dart';
import 'package:covid19_app/core/consts.dart';
import 'package:covid19_app/pages/sign_up_page.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              mainColor,
              mainColor.withOpacity(.5),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: <Widget>[
            _buildHeader(),
            Align(
              alignment: Alignment.center,
              child: Container(
                  width: MediaQuery.of(context).size.width * .75,
                  child: Image.asset("assets/images/virus.png")),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * .25,
              right: 25,
              child: Container(
                  width: MediaQuery.of(context).size.width * .4,
                  child: Image.asset("assets/images/person.png")),
            ),
            _buildFooter(context)
          ],
        ),
      ),
    );
  }

  Padding _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Align(
        alignment: Alignment.topCenter,
        child: Image.asset("assets/images/logo.png"),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Positioned(
      bottom: 35,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Koronawirus (COVID 19)",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "jest chorobą zakaźną wywołaną przez nowy \ wirus.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            RoundedButton(
              text: "ZALOGUJ",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => new LoginPage()),
                );
              },
            ),
            SizedBox(height: 15),
            RoundedButton(
              text: "ZAREJESTRUJ SIĘ",
              color: Colors.red,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => new SignUpPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
