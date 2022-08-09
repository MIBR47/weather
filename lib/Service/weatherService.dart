import 'dart:convert';

import 'package:weather_application/model/forecast_Model.dart';
import 'package:weather_application/model/weather_Model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  var apiKey = 'e253b441ac228c01226cb2ddbecfded4';
  var baseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<WeatherModel> getWeather(double lat, double long) async {
    var url = Uri.parse(
        '$baseUrl/weather?lat=$lat&lon=$long&appid=$apiKey&units=metric');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      WeatherModel weather = WeatherModel.fromJson(data);
      print(weather);

      return weather;
    } else {
      throw Exception('something went wrong with Service Get Weather');
    }
  }

  Future<List<ForecastModel>> getForecastWeather(
      double lat, double long) async {
    var apiKey = '333ae8a687035bbe74d1af6b1171aace';

    var url = Uri.parse(
        '$baseUrl/onecall?lat=$lat&lon=$long&exclude=minutely,hourly,alerts&appid=$apiKey&units=metric&lang=id');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['daily'];
      List<ForecastModel> forecast = [];
      for (var item in data) {
        forecast.add(ForecastModel.fromJson(item));
      }

      return forecast;
    } else {
      throw Exception('Salah Di Service Get Forecast');
    }
  }
}
