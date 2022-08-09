// ignore_for_file: file_names, prefer_typing_uninitialized_variables
import 'package:weather_application/model/main_Weather_Model.dart';

class ForecastDailyModel {
  var dt;
  var temp;
  double? windspeed;
  var clouds;
  double? rain;
  List<MainWeatherModel>? weather;

  ForecastDailyModel(
      {this.dt, this.temp, this.clouds, this.rain, this.weather});

  ForecastDailyModel.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    windspeed = json['wind_speed'];
    temp = json['temp']['day'];
    clouds = json['clouds'];
    rain = json['rain'];
    weather = json['weather']
        .map<MainWeatherModel>((weather) => MainWeatherModel.fromJson(weather))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'dt': dt,
      'temp': temp,
      'winds': windspeed,
      'clouds': clouds,
      'rain': rain,
      'weather': weather!.map((weather) => weather.toJson()).toList(),
    };
  }
}
