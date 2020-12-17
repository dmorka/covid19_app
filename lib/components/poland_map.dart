import 'dart:async';

import 'package:flutter/material.dart';
import 'package:covid19_app/utils/services/rest_api_service.dart';
import 'package:covid19_app/models/statistics.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class PolandMap extends StatefulWidget {
  const PolandMap({Key key}) : super(key: key);

  @override
  _PolandMapState createState() => _PolandMapState();
}

class _PolandMapState extends State<PolandMap> {
  _PolandMapState();
  Future<List<ProvinceStatisticsModel>> futureModel;

  @override
  void initState() {
    super.initState();
    futureModel = ApiDataProvider().fetchProvinceStatistics();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 520,
      child: Center(
        child: FutureBuilder<List<ProvinceStatisticsModel>>(
            future: ApiDataProvider().fetchProvinceStatistics(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);

              return snapshot.hasData
                  ? SfMaps(
                      layers: <MapShapeLayer>[
                        MapShapeLayer(
                          source: MapShapeSource.asset(
                            'assets/maps/poland-map.json',
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
                          ),
                          shapeTooltipBuilder:
                              (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.data[index].infectedCount.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          },
                          showDataLabels: true,
                          legend: MapLegend(MapElement.shape),
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
