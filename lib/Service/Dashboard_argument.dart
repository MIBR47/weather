// ignore_for_file: file_names

import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

class DashboardArguments {
  final Weather weather;
  final Position position;

  DashboardArguments(this.weather, this.position);
}
