import 'package:flutter/material.dart';
import 'package:covid19_app/models/annoucement.dart';
import 'package:covid19_app/components/content_header.dart';

class AnnouncementDataWidget extends StatelessWidget {
  final Annoucement _announcement;

  AnnouncementDataWidget(this._announcement);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Text(
                "ID: " + _announcement.id,
                style: TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.normal
                ),
              ),
            ),
            ContentHeader(name: "Opis"),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(_announcement.description),
            ),
            ContentHeader(name: "Czas dostarczenia"),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(_announcement.formatedDate()),
            ),
            ContentHeader(name: "Gdzie"),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(_announcement.address.getFullAddress()),
            )
          ]),
    );
  }
}
