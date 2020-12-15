import 'package:covid19_app/core/consts.dart';
import 'package:covid19_app/models/labs.dart';
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
      throw Exception('Failed to load province statistics');
    }
  }

  Future<GeneralStatisticsModel> fetchGeneralStatistics() async {
    final response = await http
        .get('https://coronavirus-19-api.herokuapp.com/countries/Poland');

    if (response.statusCode == 200) {
      return GeneralStatisticsModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load general statistics');
    }
  }

  Future<List<CovidLaboratoriesModel>> fetchCovidLaboratories() async {
    final response = await http.post(
      "https://positivemaps.hyperview.pl/isdp/gs/wfs",
      headers: {
        "X-Requested-With": "XMLHttpRequest",
        "Content-Type": "application/xml",
        "Referer": "https://positivemaps.hyperview.pl/gpt4/?profile=9142",
        "Origin": "https://positivemaps.hyperview.pl",
        "Sec-Fetch-Site": "same-origin",
        "Sec-Fetch-Mode": "cors",
        "Sec-Fetch-Dest": "empty",
        "Accept-Language": "pl-PL,pl;q=0.9,en-US;q=0.8,en;q=0.7"
      },
      body: COVID_LABS_REQ_BODY
    );

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      var responseJson = json.decode(body);
      return (responseJson['features'] as List)
          .map((p) => CovidLaboratoriesModel.fromJson(p))
          .toList();
    } else {
      throw Exception('Failed to load covid laboratories data');
    }
  }
}