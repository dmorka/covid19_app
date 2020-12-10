import 'package:covid19_app/components/poland_map.dart';
import 'package:covid19_app/components/menu.dart';
import 'package:covid19_app/core/consts.dart';
import 'package:covid19_app/core/flutter_icons.dart';
import 'package:covid19_app/components/chart_widget.dart';
import 'package:covid19_app/components/custom_appbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StatisticPage extends StatefulWidget {
  @override
  _StatisticPageState createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              padding: EdgeInsets.only(top: 25, bottom: 30),
              child: Stack(
                children: <Widget>[
                  Image.asset("assets/images/virus2.png"),
                  _buildHeader(),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(padding: EdgeInsets.only(top: 25)),
            _buildOverview(),
            Padding(padding: EdgeInsets.only(top: 10)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatistic() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        border: Border.all(color: Colors.white),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(1, 1),
            spreadRadius: 1,
            blurRadius: 1,
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            'Podsumowanie przypadków w Polsce',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(49, 0, 71, 1)),
          ),
          Center(
            child: FutureBuilder<GeneralStatisticsModel>(
                future: fetchGeneralStatistics(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);

                  return snapshot.hasData
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              width: 150,
                              height: 150,
                              child: DonutPieChart.createChart([
                                new Statistics(0, snapshot.data.recovered,
                                    Color.fromRGBO(209, 106, 255, 1)),
                                new Statistics(1, snapshot.data.cases,
                                    Color.fromRGBO(150, 20, 208, 1)),
                                new Statistics(2, snapshot.data.deaths,
                                    Color.fromRGBO(49, 0, 71, 1)),
                              ]),
                            ),
                            SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                _buildStatisticItem(
                                    Color.fromRGBO(150, 20, 208, 1),
                                    "Potwierdzonych",
                                    snapshot.data.cases.toString()),
                                _buildStatisticItem(
                                    Color.fromRGBO(209, 106, 255, 1),
                                    "Ozdrowienia",
                                    snapshot.data.recovered.toString()),
                                _buildStatisticItem(
                                    Color.fromRGBO(49, 0, 71, 1),
                                    "Zgony",
                                    snapshot.data.deaths.toString()),
                              ],
                            ),
                          ],
                        )
                      : Center(
                          child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.purple),
                        ));
                }),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticItem(Color color, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Icon(
          FlutterIcons.label,
          size: 50,
          color: color,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                color: Colors.black38,
              ),
            ),
            SizedBox(height: 5),
            Text(value),
          ],
        ),
      ],
    );
  }

  Widget _buildOverview() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RichText(
            text: TextSpan(
                text: "Liczba przypadków ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black87,
                ),
                children: [
                  TextSpan(
                    text: "dzisiaj",
                    style: TextStyle(
                      color: mainColor,
                    ),
                  ),
                ]),
          ),
          Padding(padding: EdgeInsets.only(top: 15)),
          PolandMap(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomAppBarWidget(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "STATYSTYKI",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
        ),
        SizedBox(height: 25),
        _buildStatistic(),
      ],
    );
  }
}

Future<GeneralStatisticsModel> fetchGeneralStatistics() async {
  final response = await http
      .get('https://coronavirus-19-api.herokuapp.com/countries/Poland');

  if (response.statusCode == 200) {
    return GeneralStatisticsModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

class GeneralStatisticsModel {
  final int cases;
  final int deaths;
  final int recovered;

  GeneralStatisticsModel({this.cases, this.deaths, this.recovered});

  factory GeneralStatisticsModel.fromJson(Map<String, dynamic> json) {
    return GeneralStatisticsModel(
      cases: json['cases'] as int,
      deaths: json['deaths'] as int,
      recovered: json['recovered'] as int,
    );
  }
}
