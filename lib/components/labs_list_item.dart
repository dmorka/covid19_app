import 'package:covid19_app/core/consts.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:covid19_app/models/labs.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:maps_launcher/maps_launcher.dart';

class LabsListItem extends StatelessWidget {

  final CovidLaboratoriesModel content;

  LabsListItem(this.content);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0)
      ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      content.name,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87
                      )
                  ),
                  SizedBox(height: 10),
                  Text(
                    content.addressCity,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 35),
                  RichText(
                    text: TextSpan(
                      text: "\u{1F4DE}" + content.phoneNum,
                      style: const TextStyle(
                        color: mainColor,
                        fontWeight: FontWeight.normal,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launch("tel://" + content.phoneNum.toString());
                        }
                    ),
                    textAlign: TextAlign.right,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "\u{1F517} Strona internetowa",
                      style: const TextStyle(
                          color: mainColor,
                          fontWeight: FontWeight.normal,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launch(content.website);
                        }
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: "\u{1F4CC} Pokaż na mapie",
                      style: const TextStyle(
                        color: mainColor,
                        fontWeight: FontWeight.normal,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          MapsLauncher.launchQuery(content.fullAddress);
                        }
                    )
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}