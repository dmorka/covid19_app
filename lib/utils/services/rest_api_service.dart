import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:covid19_app/models/statistics.dart';

class ApiDataProvider {
  static final ApiDataProvider _apiDataProvider = ApiDataProvider
      ._internal();

  factory ApiDataProvider() {
    return _apiDataProvider;
  }

  ApiDataProvider._internal();

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