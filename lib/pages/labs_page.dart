import 'package:covid19_app/components/labs_list_item.dart';
import 'package:covid19_app/components/protected_container.dart';
import 'package:covid19_app/models/labs.dart';
import 'package:covid19_app/utils/services/rest_api_service.dart';
import 'package:covid19_app/components/menu.dart';
import 'package:flutter/material.dart';
import 'package:covid19_app/core/consts.dart';
import 'package:covid19_app/components/custom_appbar_widget.dart';
import 'package:covid19_app/components/search_widget.dart';

class LabsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LabsPage();
}

class _LabsPage extends State<LabsPage> {
  List<CovidLaboratoriesModel> allLabsList = [];
  List<CovidLaboratoriesModel> filteredLabsList = [];
  SearchWidget _searchWidget;
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();

    ApiDataProvider().fetchCovidLaboratories().then((value) {
      setState(() {
        allLabsList = value;
        allLabsList.sort((CovidLaboratoriesModel a, CovidLaboratoriesModel b) {
          return a.addressCity.compareTo(b.addressCity);
        });
        filteredLabsList = List.from(allLabsList);
      });
    });

    _searchWidget = SearchWidget(
      searchQueryListener: (query) {
        setState(() {
          filteredLabsList = List.from(allLabsList.where((item) {
            String itemContent = item.fullAddress.toLowerCase().trim() +
                ' ' +
                item.name.toLowerCase().trim();
            return itemContent.contains(query.toLowerCase().trim());
          }));
        });
      },
    );
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
                child: _buildLabsList(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabsList() {
    if (allLabsList.isEmpty) {
      return Center(
          child: Container(
        margin: new EdgeInsets.only(top: 20),
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.purple),
        ),
      ));
    } else {
      return ListView.builder(
          shrinkWrap: true,
          controller: controller,
          itemCount: filteredLabsList.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return LabsListItem(filteredLabsList[index]);
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
            "LABORATORIA COVID",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: _searchWidget,
        )
      ],
    );
  }
}
