import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class WeatherApiClient {
  static const weatherBaseUrl = 'http://api.openweathermap.org';
  static const citiesBaseUrl = 'https://blue-eye.ru';
  static const weatherApiKey= '4d9e89ec7c21cf2c4d16afacc7d2aee8';
  final http.Client httpClient;

  WeatherApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<dynamic> getWeatherForCity(String city) async {
    final apiUrl = '$weatherBaseUrl/data/2.5/weather?q=$city&appid=$weatherApiKey&units=metric';
    final response = await this.httpClient.get(apiUrl);
    if (response.statusCode == 404) {
      throw Exception('Unknown city');
    } else  if (response.statusCode == 401) {
      throw Exception('Authorization error');
    } else if (response.statusCode != 200) {
      throw Exception('Unexpected server error');
    }

    final responseJson = jsonDecode(response.body);
    return responseJson;
  }

  Future<dynamic> getCities(String query) async {
    final apiUrl = '$citiesBaseUrl/WeatherQuery.php?q=%$query&b=Bawa21232asWdswq1563';
    final response = await this.httpClient.get(apiUrl);
    if (response.statusCode != 200 && response.body.contains("status:not found")) {
      throw Exception('Unknown city');
    } else if (response.statusCode != 200 && response.body.contains("status:auth error")) {
      throw Exception('Authorization error');
    } else if (response.statusCode != 200) {
      throw Exception('Unexpected server error');
    }

    final responseJson = jsonDecode(response.body);
    return responseJson;
  }

}