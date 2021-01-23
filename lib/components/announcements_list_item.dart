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
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            color: backgroundColor,
            boxShadow: [
              BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0)
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                        color: mainColor,
                      ),
                      child: Row(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              child: Text(content.title,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ))),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                        color: backgroundColor,
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Text(
                          content.description.length > 200
                              ? content.description.substring(0, 200) + "..."
                              : content.description,
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.normal,
                          ),
                        ),),
                    ),
                    SizedBox(height: 35),
                    Text(
                      "Czas dostarczenia: " + content.formatedDate(),
                      style: TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    Text(
                      "Gdzie: ",
                      style: TextStyle(
                          color: Colors.black45, fontWeight: FontWeight.normal),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
