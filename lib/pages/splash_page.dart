import 'dart:async';

import 'package:flutter/material.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weather/weather.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_application/Service/Dashboard_argument.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _MSplashPage();
}

class _MSplashPage extends State<SplashPage> {
  String currentAddress = 'My Address';
  Position? currentposition;
  @override
  void initState() {
    // clear();
    // getregion();
    _determinePosition();
    // Timer(
    //   const Duration(seconds: 2),
    //   () => Navigator.of(context).pushReplacementNamed('/dashboard'),
    // );

    super.initState();
  }

  queryWeather(Position currentposition) async {
    /// Removes keyboard
    // FocusScope.of(context).requestFocus(FocusNode());
    double lat = currentposition.latitude;
    double lon = currentposition.longitude;
    String key = "e253b441ac228c01226cb2ddbecfded4";
    late WeatherFactory ws;
    Weather? _data;
    ws = WeatherFactory(key);
    Weather weather = await ws.currentWeatherByLocation(lat, lon);

    Navigator.of(context).pushReplacementNamed(
      '/dashboard',
      arguments: DashboardArguments(weather, currentposition),
    );
  }

  Future<Position?> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Please Keep your location on.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location Permission is denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: 'Permission is denied Forever');
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      if (mounted) {
        setState(
          () {
            currentposition = position;
            currentAddress =
                " ${place.street}, ${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea} ${place.postalCode}";
            queryWeather(currentposition!);
            // Loader.hide();
          },
        );
      }

      return currentposition;
    } catch (e) {
      print(e);

      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.sunny_snowing,
              color: Colors.amber[400],
              size: 100.0,
            ),
            LoadingAnimationWidget.staggeredDotsWave(
              size: 74,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
