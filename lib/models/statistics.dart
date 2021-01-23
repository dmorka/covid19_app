class GeneralStatisticsModel {
  final int cases;
  final int deaths;
  final int recovered;

  GeneralStatisticsModel(
      {this.cases, this.deaths, this.recovered});

  factory GeneralStatisticsModel.fromJson(Map<String, dynamic> json) {
    return GeneralStatisticsModel(
      cases: json['LICZBA_ZAKAZEN'] as int,
      deaths: json['LICZBA_ZGONOW'] as int,
      recovered: json['LICZBA_OZDROWIENCOW'] as int,
    );
  }
}

class ProvinceStatisticsModel {
  final String stateName;
  final int infectedCount;
  final int deceasedCount;

  ProvinceStatisticsModel(
      {this.stateName, this.infectedCount, this.deceasedCount});



  factory ProvinceStatisticsModel.fromJson(Map<String, dynamic> json) {
    return ProvinceStatisticsModel(
      stateName: json['region'] as String,
      infectedCount: json['infectedCount'] as int,
      deceasedCount: json['deceasedCount'] as int,
    );
  }
}
