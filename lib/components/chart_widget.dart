import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class DonutPieChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DonutPieChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory DonutPieChart.withSampleData() {
    return new DonutPieChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList,
        animate: animate,
        // Configure the width of the pie slices to 60px. The remaining space in
        // the chart will be left as a hole in the center.
        defaultRenderer: new charts.ArcRendererConfig(arcWidth: 20));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<Statistics, int>> _createSampleData() {
    final data = [
      new Statistics(0, 25, Colors.redAccent),
      new Statistics(1, 75, Colors.yellowAccent),
      new Statistics(2, 150, Colors.blueAccent),
    ];

    return [
      new charts.Series<Statistics, int>(
        id: 'Sales',
        domainFn: (Statistics statistics, _) => statistics.id,
        measureFn: (Statistics statistics, _) => statistics.value,
        colorFn: (Statistics statistics, _) =>
            charts.ColorUtil.fromDartColor(statistics.color),
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class Statistics {
  final int id;
  final int value;
  final Color color;

  Statistics(this.id, this.value, this.color);
}
