// import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:covid19_app/pages/announcement_page.dart';
import 'package:covid19_app/components/announcements_list_item_data_widget.dart';
import 'package:covid19_app/models/annoucement.dart';
import 'package:covid19_app/models/user.dart';
import 'package:covid19_app/core/consts.dart';

class AnnouncementsListItem extends StatelessWidget {
  final Annoucement content;

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
      child: AnnouncementsListItemDataWidget(content)
    );
  }
}
