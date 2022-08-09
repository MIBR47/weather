// ignore_for_file: file_names

import 'dart:convert';

import 'package:weather_application/model/forecast_Model.dart';
import 'package:weather_application/model/weather_Model.dart';
// ignore: depend_on_referenced_packages
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

  Future<ForecastModel> getForecastWeather(double lat, double long) async {
    var url = Uri.parse(
        '$baseUrl/onecall?lat=$lat&lon=$long&exclude=minutely,hourly,alerts&appid=$apiKey&units=metric&lang=id');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      ForecastModel forecast = ForecastModel.fromJson(data);

      print('test');
      print(forecast);

      return forecast;
    } else {
      throw Exception('something went wrong with Service Get Forecast');
    }
  }

  Future<WeatherModel> getWeatherByCityName(String city) async {
    var url = Uri.parse('$baseUrl/weather?q=$city&appid=$apiKey&units=metric');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      WeatherModel weather = WeatherModel.fromJson(data);

      return weather;
    } else {
      throw Exception(
          'something went wrong with Service Get Weather by City Name');
    }
  }
}
