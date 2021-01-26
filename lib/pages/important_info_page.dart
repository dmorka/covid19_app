import 'dart:ui';

import 'package:covid19_app/components/protected_container.dart';
import 'package:covid19_app/core/consts.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:covid19_app/components/content_header.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:covid19_app/components/custom_appbar_widget.dart';
import 'package:covid19_app/components/menu.dart';

class ImportantInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProtectedContainer(
      body: Scaffold(
        backgroundColor: backgroundColor,
        drawer: MenuDrawer(),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ContentHeader(name: "Rządowa strona internetowa z informacjami nt. koronawirusa"),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      text: '\u{1F517} https://www.gov.pl/web/koronawirus',
                      style: const TextStyle(
                        color: mainColor,
                        fontWeight: FontWeight.normal,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launch('https://www.gov.pl/web/koronawirus');
                        }
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

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomAppBarWidget(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Ważne informacje",
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
