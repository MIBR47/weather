import 'dart:async';

import 'package:flutter/material.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:weather/weather.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_application/argument/Dashboard_argument.dart';
import 'package:weather_application/provider/weather_Provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _MSplashPage();
}

class _MSplashPage extends State<SplashPage> {
  String currentAddress = 'My Address';
  Position? currentposition;
  String key = "e253b441ac228c01226cb2ddbecfded4";
  late WeatherFactory ws;
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
        getWeather(position);
        getForecast(position);
        currentAddress =
            " ${place.street}, ${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea} ${place.postalCode}";
      }

      return currentposition;
    } catch (e) {
      // ignore: avoid_print
      print(e);

      return null;
    }
  }

  getWeather(Position currentposition) async {
    // await Provider.of<LocationProvider>(context, listen: false)
    //     .getCurrentLocation();

    double lat = currentposition.latitude;
    double long = currentposition.longitude;

    await Provider.of<WeatherProvider>(context, listen: false)
        .getWeather(lat, long);

    if (mounted) {
      Navigator.of(context).pushReplacementNamed(
        '/dashboard',
        arguments: DashboardArguments(currentposition),
      );
    }

    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  getForecast(Position currentposition) async {
    double lat = currentposition.latitude;
    double long = currentposition.longitude;
    await Provider.of<WeatherProvider>(context, listen: false)
        .getforecast(lat, long);
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
