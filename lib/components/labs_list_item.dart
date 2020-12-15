import 'package:covid19_app/models/labs.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

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
                    content.fullAddress,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 35),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: IconButton(
                              icon: Icon(Icons.phone),
                              color: Colors.blue,
                              onPressed: () {
                                launch("tel://" + content.phoneNum.toString());
                              },
                              padding: EdgeInsets.all(10),
                            )),
                        SizedBox(width: 4),
                        Expanded(
                          child: IconButton(
                            icon: Icon(Icons.language),
                            color: Colors.blue,
                            onPressed: () {
                              launch(content.website);
                            },
                            padding: EdgeInsets.all(10),
                          ),
                        ),
                        SizedBox(width: 4),
                        Expanded(
                          child: IconButton(
                            icon: Icon(Icons.map),
                            color: Colors.blue,
                            onPressed: () {
                              MapsLauncher.launchQuery(content.fullAddress);
                            },
                            padding: EdgeInsets.all(10),
                          ),
                        )
                      ],
                    ),
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