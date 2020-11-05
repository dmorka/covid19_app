import 'package:covid19_app/components/menu.dart';
import 'package:flutter/material.dart';
import 'package:covid19_app/core/consts.dart';
import 'package:covid19_app/components/list_item.dart';
import 'package:covid19_app/components/custom_appbar_widget.dart';

class AnnouncementsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage> {
  List<Widget> itemsData = [];
  ScrollController controller = ScrollController();

  void getPostsData() {
    List<dynamic> responseList = ANNOUNCEMENT_DATA;
    List<Widget> listItems = [];
    responseList.forEach((post) {
      listItems.add(ListItem(post));
    });
    setState(() {
      itemsData = listItems;
    });
  }

  @override
  void initState() {
    super.initState();
    getPostsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      drawer: MenuDrawer(),
      body: Stack(
        children: <Widget>[
          Container(
            height: 275,
            decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            padding: EdgeInsets.only(top: 25, bottom: 30),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Image.asset("assets/images/virus2.png"),
            ),
          ),
          Container(
            child: ListView(
              children: <Widget>[
                CustomAppBarWidget(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "ANNOUNCEMENTS",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: _buildAnnouncements(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAnnouncements() {
    return ListView.builder(
        shrinkWrap: true,
        controller: controller,
        itemCount: itemsData.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return itemsData[index];
        });
  }
}
