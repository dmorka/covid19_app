// import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:covid19_app/pages/announcement_page.dart';
import 'package:covid19_app/models/annoucement.dart';
import 'package:covid19_app/models/user.dart';
import 'package:covid19_app/core/consts.dart';

class AnnouncementsListItem extends StatelessWidget {
  final Annoucement content;
  UserModel userModel;

  AnnouncementsListItem(this.content);

  factory AnnouncementsListItem.withContent(map) {
    return new AnnouncementsListItem(map);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => AnnouncementPage(announcement: content)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        // padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: backgroundColor,
          boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(80), blurRadius: 40.0)
          ]),
        child:
        Row(
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
                              child: Text(content.title,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ))),
                        ],
                      ),
                    ),
                    // SizedBox(height: 10),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                        child: Text(
                          content.description.length > 200
                              ? content.description.substring(0, 200) + "..."
                              : content.description,
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Text(
                        "Czas dostarczenia: " + content.formatedDate(),
                        style: TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 10), child: Text(
                      "Gdzie: " + content.address.getFullAddress(),
                      style: TextStyle(
                          color: Colors.black45, fontWeight: FontWeight.normal),
                    ),)
                  ],
                ),
              ),),
            ],
          ),
        // ),
      ),
    );
  }
}
