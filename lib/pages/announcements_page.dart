import 'package:covid19_app/components/menu.dart';
import 'package:covid19_app/components/protected_container.dart';
import 'package:covid19_app/models/annoucement.dart';
import 'package:flutter/material.dart';
import 'package:covid19_app/core/consts.dart';
import 'package:covid19_app/components/announcements_list_item.dart';
import 'package:covid19_app/components/custom_appbar_widget.dart';
import 'package:covid19_app/utils/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AnnouncementsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage> {
  List<Annoucement> announcementsList = [];
  ScrollController controller = ScrollController();

  void getPostsData() {
    FirebaseFirestoreService()
        .getAnnoucementsOfOthers(FirebaseAuth.instance.currentUser.uid)
        .then((value) {
      if (mounted){
        setState(() {
          announcementsList = value;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    getPostsData();
  }

  @override
  Widget build(BuildContext context) {
    return ProtectedContainer(
      body: Scaffold(
        // resizeToAvoidBottomPadding: false,
        backgroundColor: backgroundColor,
        drawer: MenuDrawer(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                padding: EdgeInsets.only(top: 25),
                child: Stack(
                  children: <Widget>[
                    Image.asset("assets/images/virus2.png"),
                    _buildHeader(),
                  ],
                ),
              ),
              // SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: _buildAnnouncements(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnnouncements() {
    if (announcementsList.isEmpty) {
      return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.purple),
          ));
    } else {
      return ListView.builder(
          shrinkWrap: true,
          controller: controller,
          itemCount: announcementsList.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return AnnouncementsListItem(announcementsList[index]);
          });
    }
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomAppBarWidget(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "OGŁOSZENIA",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
        ),
      ],
    );
  }
}
