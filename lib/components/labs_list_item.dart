import 'package:covid19_app/core/consts.dart';
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
      // padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: backgroundColor,
          boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(80), blurRadius: 40.0)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    // padding: ,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10)),
                      color: mainColor,
                    ),
                    child: Row(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                            child: Container(
                              width: MediaQuery.of(context).size.width * .75,
                              child: Text(content.name,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  )),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Text(
                      content.fullAddress,
                      style: TextStyle(
                          color: Colors.black45, fontWeight: FontWeight.normal),
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: IconButton(
                          icon: Icon(
                            Icons.phone,
                            color: mainColor,
                          ),
                          color: Colors.blue,
                          onPressed: () {
                            launch("tel://" + content.phoneNum.toString());
                          },
                          padding: EdgeInsets.all(10),
                        )),
                        SizedBox(width: 4),
                        Expanded(
                          child: IconButton(
                            icon: Icon(
                              Icons.language,
                              color: mainColor,
                            ),
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
                            icon: Icon(
                              Icons.map,
                              color: mainColor,
                            ),
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
          ),
        ],
      ),
      // ),
    );
  }
}
