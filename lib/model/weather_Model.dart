// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'package:weather_application/model/main_Weather_Model.dart';
import 'package:weather_application/model/temperature_Model.dart';

class WeatherModel {
  String? name;
  List<MainWeatherModel>? weather;
  TemperatureModel? mainTemp;
  int? clouds;
  int? dt;
  int? timezone;
  double? lon;
  double? lat;

  WeatherModel({
    this.name,
    this.weather,
    this.mainTemp,
    this.clouds,
    this.lon,
    this.lat,
  });

  WeatherModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    weather = json['weather']
        .map<MainWeatherModel>((weather) => MainWeatherModel.fromJson(weather))
        .toList();
    mainTemp = TemperatureModel.fromJson(json['main']);
    dt = json['dt'];
    timezone = json['timezone'];
    clouds = json['clouds']['all'];
    lon = json['coord']['lon'];
    lat = json['coord']['lat'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'weather': weather!.map((weather) => weather.toJson()).toList(),
      'main': mainTemp!.toJson(),
      'dt': dt,
      'timezone': timezone,
      'all': clouds,
      'lon': lon,
      'lat': lat
    };
  }
}
