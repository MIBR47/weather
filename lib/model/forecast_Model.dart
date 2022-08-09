// ignore_for_file: file_names, prefer_typing_uninitialized_variables
import 'package:weather_application/model/forecastDaily_Model.dart';
import 'package:weather_application/model/main_Weather_Model.dart';

class ForecastModel {
  int? timezone;
  List<ForecastDailyModel>? daily;

  ForecastModel({
    this.timezone,
    this.daily,
  });

  ForecastModel.fromJson(Map<String, dynamic> json) {
    timezone = json['timezone_offset'];
    daily = json['daily']
        .map<ForecastDailyModel>((daily) => ForecastDailyModel.fromJson(daily))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'timezone_offset': timezone,
    };
  }
}
