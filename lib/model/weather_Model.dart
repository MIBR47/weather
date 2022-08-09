// ignore: file_names
import 'package:weather_application/model/main_Weather_Model.dart';
import 'package:weather_application/model/temperature_Model.dart';

class WeatherModel {
  String? name;
  List<MainWeatherModel>? mainWeather;
  TemperatureModel? mainTemp;
  int? clouds;
  int? dt;
  int? timezone;
  double? lon;
  double? lat;

  WeatherModel({
    this.name,
    this.mainWeather,
    this.mainTemp,
    this.clouds,
    this.lon,
    this.lat,
  });

  WeatherModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mainWeather = json['weather']
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
      'weather': mainWeather!.map((weather) => weather.toJson()).toList(),
      'main': mainTemp!.toJson(),
      'dt': dt,
      'timezone': timezone,
      'all': clouds,
      'lon': lon,
      'lat': lat
    };
  }
}
