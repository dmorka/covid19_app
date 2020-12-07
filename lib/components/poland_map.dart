import 'package:covid19_app/core/model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class PolandMap extends StatefulWidget {
  const PolandMap({Key key}) : super(key: key);

  @override
  _PolandMapState createState() => _PolandMapState();
}

class _PolandMapState extends State<PolandMap> {
  _PolandMapState();

  List<Model> data;

  @override
  void initState() {
    data = const <Model>[
      Model('śląskie', 50),
      Model('opolskie', 300),
      Model('wielkopolskie', 250),
      Model('zachodniopomorskie', 700),
      Model('świętokrzyskie', 127),
      Model('kujawsko-pomorskie', 345),
      Model('podlaskie', 452),
      Model('dolnośląskie', 753),
      Model('podkarpackie', 100),
      Model('małopolskie', 325),
      Model('pomorskie', 252),
      Model('warmińsko-mazurskie', 642),
      Model('łódzkie', 42),
      Model('mazowieckie', 12),
      Model('lubelskie', 163),
      Model('lubuskie', 235),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 520,
      child: Center(
        child: SfMaps(
          layers: <MapShapeLayer>[
            MapShapeLayer(
              delegate: MapShapeLayerDelegate(
                // shapeFile: 'assets/australia.json',
                shapeFile: 'assets/maps/poland-map.json',
                shapeDataField: 'STATE_NAME',
                dataCount: data.length,
                primaryValueMapper: (int index) => data[index].stateName,
                dataLabelMapper: (int index) => data[index].stateName,
                shapeColorValueMapper: (int index) => data[index].numberOfCases,
                shapeColorMappers: [
                  MapColorMapper(
                      from: 0,
                      to: 100,
                      color: Color.fromRGBO(209, 106, 255, 1),
                      text: '< 100'),
                  MapColorMapper(
                      from: 101,
                      to: 300,
                      color: Color.fromRGBO(187, 68, 240, 1),
                      text: '101 - 300'),
                  MapColorMapper(
                      from: 301,
                      to: 500,
                      color: Color.fromRGBO(150, 20, 208, 1),
                      text: '301 - 500'),
                  MapColorMapper(
                      from: 501,
                      to: 700,
                      color: Color.fromRGBO(102, 0, 148, 1),
                      text: '500 - 700'),
                  MapColorMapper(
                      from: 701,
                      to: 10000,
                      color: Color.fromRGBO(49, 0, 71, 1),
                      text: '700 <'),
                ],
                shapeTooltipTextMapper: (int index) => data[index].stateName,
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
                      fontSize: Theme.of(context).textTheme.caption.fontSize)),
            ),
          ],
        ),
      ),
    );
  }
}
