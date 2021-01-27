// import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:covid19_app/pages/users_created_announcement_page.dart';
import 'package:covid19_app/models/annoucement.dart';
import 'package:covid19_app/models/user.dart';
import 'package:covid19_app/core/consts.dart';
import 'package:covid19_app/components/announcements_list_item_data_widget.dart';

class UsersCreatedAnnouncementsListItem extends StatelessWidget {
  final Annoucement content;

  UsersCreatedAnnouncementsListItem(this.content);

  factory UsersCreatedAnnouncementsListItem.withContent(map) {
    return new UsersCreatedAnnouncementsListItem(map);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => UsersCreatedAnnouncementPage(announcementId: content.id)));
      },
      child: AnnouncementsListItemDataWidget(content)
    );
  }
}
