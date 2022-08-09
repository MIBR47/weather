import 'package:flutter/widgets.dart';
import 'package:weather_application/Service/weatherService.dart';
import 'package:weather_application/model/weather_Model.dart';

class WeatherProvider with ChangeNotifier {
  WeatherModel? _weather;

  WeatherModel get weather => _weather as WeatherModel;

  set weather(WeatherModel weather) {
    _weather = weather;
    notifyListeners();
  }

  Future<void> getWeather(double lat, double long) async {
    try {
      WeatherModel weather = await WeatherService().getWeather(lat, long);
      _weather = weather;
    } catch (e) {
      print(e);
      print('something went wrong with Provider get weahter');
    }
  }
}
