import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:provider/provider.dart';

import 'package:weather/weather.dart';
import 'package:intl/intl.dart';

import 'package:weather_application/provider/weather_Provider.dart';

import 'package:weather_application/theme.dart';
import 'package:weather_application/widget/menu_card.dart';

// enum weatherCondition{cloud.png,};

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

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
    // final data = ModalRoute.of(context)?.settings.arguments as FilterArguments;
    var weatherProvider = Provider.of<WeatherProvider>(context);
    // final position = ModalRoute.of(context)?.settings.arguments as Weather;

    Widget nama() {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 12, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        weatherProvider.weather.name!,
                        textAlign: TextAlign.left,
                        style: whiteTextStyle.copyWith(
                            fontSize: 20, fontWeight: semiBold),
                      ),
                      Text(
                        formatter
                            .format(DateTime.fromMillisecondsSinceEpoch(
                                weatherProvider.weather.dt! * 1000))
                            .toString(),
                        textAlign: TextAlign.left,
                        style: whiteTextStyle.copyWith(
                            fontSize: 16, fontWeight: semiBold),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      );
    }

    Widget menu() {
      return Container(
        margin: const EdgeInsets.only(top: 18),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TemperatureCard(
            //   temperature: data.weather.temperature.toString(),
            // ),
            WeatherCard(
              weather:
                  weatherProvider.weather.weather![0].mainWeather.toString(),
            ),
            ElseCard(
              data:
                  "${weatherProvider.weather.mainTemp!.feelsLike.toString()}\u2103",
              name: "Feels Like",
              fontsize: 30,
            ),
            ElseCard(
              data: weatherProvider.weather.mainTemp!.humidity.toString(),
              name: "Humidity",
              fontsize: 32,
            ),
            ElseCard(
              data: "${weatherProvider.weather.mainTemp!.pressure}hPa",
              name: "Air Pressure",
              fontsize: 23,
            ),
          ],
        ),
      );
    }

    Widget header() {
      return Stack(
        // alignment: AlignmentDirectional.center,
        children: [
          WeatherBg(
            weatherType: weatherBackgroud(
                weatherProvider.weather.weather![0].mainWeather.toString()),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
