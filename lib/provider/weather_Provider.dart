import 'package:flutter/widgets.dart';
import 'package:weather_application/Service/weatherService.dart';
import 'package:weather_application/model/forecast_Model.dart';
import 'package:weather_application/model/weather_Model.dart';

class WeatherProvider with ChangeNotifier {
  WeatherModel? _weather;
  ForecastModel? _forecast;

  WeatherModel get weather => _weather as WeatherModel;
  ForecastModel get forecast => _forecast as ForecastModel;

  set weather(WeatherModel weather) {
    _weather = weather;
    notifyListeners();
  }

  set forecast(ForecastModel forecast) {
    _forecast = forecast;
    notifyListeners();
  }

  Future<bool> getWeather(double lat, double long) async {
    try {
      WeatherModel weather = await WeatherService().getWeather(lat, long);
      _weather = weather;
      return true;
    } catch (e) {
      print(e);
      print('something went wrong with Provider get weahter');
      return false;
    }
  }

  Future<bool> getforecast(var lat, var long) async {
    try {
      ForecastModel forecast =
          await WeatherService().getForecastWeather(lat, long);
      _forecast = forecast;
      return true;
    } catch (e) {
      Exception(e);
      Exception('Salah di get Forecast provider');
      return false;
    }
  }

  Future<bool> getWeatherCity(String city) async {
    try {
      WeatherModel weather = await WeatherService().getWeatherByCityName(city);
      _weather = weather;
      return true;
    } catch (e) {
      print(e);
      print('Salah di Provider');
      return false;
    }
  }
}
