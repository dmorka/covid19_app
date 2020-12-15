import 'package:http/http.dart' as http;
import 'dart:convert';

class GeneralStatisticsModel {
  final int cases;
  final int deaths;
  final int recovered;

  GeneralStatisticsModel(
      {this.cases, this.deaths, this.recovered});

  factory GeneralStatisticsModel.fromJson(Map<String, dynamic> json) {
    return GeneralStatisticsModel(
      cases: json['cases'] as int,
      deaths: json['deaths'] as int,
      recovered: json['recovered'] as int,
    );
  }
}

class GeneralStatistics {

  static final GeneralStatistics _generalStatistics = GeneralStatistics
      ._internal();

  factory GeneralStatistics() {
    return _generalStatistics;
  }

  GeneralStatistics._internal();

  Future<GeneralStatisticsModel> fetchGeneralStatistics() async {
    final response = await http
        .get('https://coronavirus-19-api.herokuapp.com/countries/Poland');

    if (response.statusCode == 200) {
      return GeneralStatisticsModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
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

class ProvinceStatistics {

  static final ProvinceStatistics _provinceStatistics = ProvinceStatistics
      ._internal();

  factory ProvinceStatistics() {
    return _provinceStatistics;
  }

  ProvinceStatistics._internal();

  Future<List<ProvinceStatisticsModel>> fetchProvinceStatistics() async {
    final response = await http.get(
        'https://api.apify.com/v2/key-value-stores/3Po6TV7wTht4vIEid/records/LATEST?disableRedirect=true');

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      return (responseJson['infectedByRegion'] as List)
          .map((p) => ProvinceStatisticsModel.fromJson(p))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}