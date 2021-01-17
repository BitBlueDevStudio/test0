import 'package:weather_app/repo/weather_api.dart';

class WeatherRepository {
  final WeatherApiClient wApi;

  WeatherRepository(this.wApi);

  Future<dynamic> getWeatherForCity(String city) async {
    return wApi.getWeatherForCity(city);
  }

  Future<dynamic> getCitiesForQuery(String query) async {
    return wApi.getCities(query);
  }

}