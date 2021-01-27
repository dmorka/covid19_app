// import 'dart:ui';

import 'package:covid19_app/pages/users_accepted_announcement_page.dart';
import 'package:flutter/material.dart';
import 'package:covid19_app/models/annoucement.dart';
import 'package:covid19_app/components/announcements_list_item_data_widget.dart';

class UsersAcceptedAnnouncementsListItem extends StatelessWidget {
  final Annoucement content;

  UsersAcceptedAnnouncementsListItem(this.content);

  factory UsersAcceptedAnnouncementsListItem.withContent(map) {
    return new UsersAcceptedAnnouncementsListItem(map);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => UsersAcceptedAnnouncementPage(announcement: content)));
        },
        child: AnnouncementsListItemDataWidget(content)
    );
  }
}
