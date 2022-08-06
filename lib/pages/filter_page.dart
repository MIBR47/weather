import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';
import 'package:weather/weather.dart';
import 'package:intl/intl.dart';
import 'package:weather_application/Service/Dashboard_argument.dart';
import 'package:weather_application/Service/filter_argument.dart';
import 'package:weather_application/pages/search_page.dart';
import 'package:weather_application/pages/splash_page.dart';
import 'package:weather_application/pages/weather_forecast_list_pages.dart';
import 'package:weather_application/theme.dart';
import 'package:weather_application/widget/menu_card.dart';
import 'package:weather_application/widget/weather_forecast_card.dart';
import 'package:page_transition/page_transition.dart';

// enum weatherCondition{cloud.png,};

class FilterPage extends StatefulWidget {
  FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final DateFormat formatter = DateFormat('E, dd MMM yyyy');
  late WeatherFactory wf;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // WeatherFactory wf = WeatherFactory(key);
    // late Weather? data = _data;
    final data = ModalRoute.of(context)?.settings.arguments as filterArguments;
    // final position = ModalRoute.of(context)?.settings.arguments as Weather;

    Widget nama() {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 30, right: 12, top: 10),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.weather.areaName.toString(),
                            textAlign: TextAlign.left,
                            style: whiteTextStyle.copyWith(
                                fontSize: 20, fontWeight: semiBold),
                          ),
                          Text(
                            formatter.format(data.weather.date!).toString(),
                            textAlign: TextAlign.left,
                            style: whiteTextStyle.copyWith(
                                fontSize: 16, fontWeight: semiBold),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }

    Widget menu() {
      return Container(
        margin: EdgeInsets.only(top: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TemperatureCard(
              temperature: data.weather.temperature.toString(),
            ),
            SizedBox(
              width: 10,
            ),
            WeatherCard(
              weather: data.weather.weatherMain.toString(),
            ),
          ],
        ),
      );
    }

    Widget header() {
      return Stack(
        children: [
          WeatherBg(
            weatherType: weatherBackgroud(data.weather.weatherMain.toString()),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),

          // decoration: const BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage('assets/header.png'),
          //     fit: BoxFit.fill,
          //   ),
          // ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // BackdropFilter(
              //   filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
              //   child: Padding(
              //     padding: EdgeInsets.only(top: 20),
              //     child: search(),
              //   ),
              // ),
              Column(
                children: [
                  nama(),
                  menu(),
                ],
              ),
            ],
          ),
        ],
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Wrap(
          children: [
            header(),
          ],
        ),
      ),
    );
  }
}

WeatherType weatherBackgroud(String weather) {
  WeatherType type;

  switch (weather) {
    case "Clear":
      type = WeatherType.sunny;
      break;
    case "Clouds":
      type = WeatherType.cloudyNight;
      break;
    case "Rain":
      type = WeatherType.heavyRainy;
      break;
    case "Drizzle":
      type = WeatherType.lightRainy;
      break;
    case "Thunderstorm":
      type = WeatherType.thunder;
      break;
    case "Snow":
      type = WeatherType.lightSnow;
      break;
    default:
      type = WeatherType.sunny;
  }

  return type;
}
