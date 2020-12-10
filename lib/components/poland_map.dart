import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:http/http.dart' as http;

class PolandMap extends StatefulWidget {
  const PolandMap({Key key}) : super(key: key);

  @override
  _PolandMapState createState() => _PolandMapState();
}

class _PolandMapState extends State<PolandMap> {
  _PolandMapState();
  Future<List<Model>> futureModel;

  @override
  void initState() {
    super.initState();
    futureModel = fetchModels();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 520,
      child: Center(
        child: FutureBuilder<List<Model>>(
            future: fetchModels(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);

              return snapshot.hasData
                  ? SfMaps(
                      layers: <MapShapeLayer>[
                        MapShapeLayer(
                          delegate: MapShapeLayerDelegate(
                            shapeFile: 'assets/maps/poland-map.json',
                            shapeDataField: 'STATE_NAME',
                            dataCount: snapshot.data.length,
                            primaryValueMapper: (int index) =>
                                snapshot.data[index].stateName,
                            dataLabelMapper: (int index) =>
                                snapshot.data[index].stateName,
                            shapeColorValueMapper: (int index) =>
                                snapshot.data[index].infectedCount,
                            shapeColorMappers: [
                              MapColorMapper(
                                  from: 0,
                                  to: 400,
                                  color: Color.fromRGBO(209, 106, 255, 1),
                                  text: '< 400'),
                              MapColorMapper(
                                  from: 401,
                                  to: 600,
                                  color: Color.fromRGBO(187, 68, 240, 1),
                                  text: '401 - 600'),
                              MapColorMapper(
                                  from: 601,
                                  to: 800,
                                  color: Color.fromRGBO(150, 20, 208, 1),
                                  text: '601 - 800'),
                              MapColorMapper(
                                  from: 801,
                                  to: 1000,
                                  color: Color.fromRGBO(102, 0, 148, 1),
                                  text: '800 - 1000'),
                              MapColorMapper(
                                  from: 1001,
                                  to: 10000,
                                  color: Color.fromRGBO(49, 0, 71, 1),
                                  text: '1000 <'),
                            ],
                            shapeTooltipTextMapper: (int index) =>
                                snapshot.data[index].infectedCount.toString(),
                          ),
                          showDataLabels: true,
                          legendSource: MapElement.shape,
                          enableShapeTooltip: true,
                          tooltipSettings: MapTooltipSettings(
                              color: Colors.purple,
                              strokeColor: Colors.white,
                              strokeWidth: 2),
                          strokeColor: Colors.black38,
                          strokeWidth: 1,
                          dataLabelSettings: MapDataLabelSettings(
                            textStyle: TextStyle(
                              color: Colors.white10,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  Theme.of(context).textTheme.caption.fontSize,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.purple),
                    ));
            }),
      ),
    );
  }
}

Future<List<Model>> fetchModels() async {
  final response = await http.get(
      'https://api.apify.com/v2/key-value-stores/3Po6TV7wTht4vIEid/records/LATEST?disableRedirect=true');

  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
    return (responseJson['infectedByRegion'] as List)
        .map((p) => Model.fromJson(p))
        .toList();
  } else {
    throw Exception('Failed to load model');
  }
}

class Model {
  final String stateName;
  final int infectedCount;
  final int deceasedCount;

  Model({this.stateName, this.infectedCount, this.deceasedCount});

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      stateName: json['region'] as String,
      infectedCount: json['infectedCount'] as int,
      deceasedCount: json['deceasedCount'] as int,
    );
  }
}