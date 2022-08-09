import 'package:weather_application/model/Main_Weather_Model.dart';

class ForecastModel {
  var dt;
  double? temp;
  double? windspeed;

  double? rain;
  List<MainWeatherModel>? weather;

  ForecastModel({
    this.dt,
    this.temp,
    this.rain,
    this.weather,
  });

  ForecastModel.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    windspeed = json['wind_speed'];
    temp = json['temp']['day'];

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
      'rain': rain,
      'weather': weather!.map((weather) => weather.toJson()).toList(),
    };
  }
}
