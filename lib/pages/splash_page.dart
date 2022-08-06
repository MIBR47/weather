import 'dart:async';

import 'package:flutter/material.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weather/weather.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _MSplashPage();
}

class _MSplashPage extends State<SplashPage> {
  @override
  void initState() {
    // clear();
    // getregion();
    queryWeather();
    // Timer(
    //   const Duration(seconds: 2),
    //   () => Navigator.of(context).pushReplacementNamed('/dashboard'),
    // );

    super.initState();
  }

  queryWeather() async {
    /// Removes keyboard
    // FocusScope.of(context).requestFocus(FocusNode());
    double lat = -6.245185939299144;
    double lon = 106.96004566267743;
    String key = "e253b441ac228c01226cb2ddbecfded4";
    late WeatherFactory ws;
    Weather? _data;
    ws = WeatherFactory(key);
    Weather weather = await ws.currentWeatherByLocation(lat, lon);
    print(weather);
    // setState(() {
    //   _data = weather;
    //   // _state = AppState.FINISHED_DOWNLOADING;
    // });
    Navigator.of(context)
        .pushReplacementNamed('/dashboard', arguments: weather);
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
