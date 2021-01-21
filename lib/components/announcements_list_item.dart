
import 'package:flutter/material.dart';
import 'package:covid19_app/pages/announcement_page.dart';
import 'package:covid19_app/models/annoucement.dart';
import 'package:covid19_app/models/user.dart';

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
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AnnouncementPage(announcement: content)
          )
        );
      },
      child: Container(
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
                      content.title,
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87
                      )
                    ),
                    SizedBox(height: 10),
                    Text(
                      content.description.length > 200 ?  content.description.substring(0, 200) + "..." : content.description,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 35),
                    Text(
                      "Czas dostarczenia: " + content.formatedDate(),
                      style: const TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    Text(
                      "Gdzie: ",
                      style: const TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.normal
                      ),
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