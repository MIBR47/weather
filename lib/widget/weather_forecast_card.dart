import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_application/theme.dart';

class weatherForecastCard extends StatelessWidget {
  Weather weather;
  weatherForecastCard({required this.weather, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('E, dd MMM yyyy');
    final DateFormat formatterTime = DateFormat.jm();
    String temperature = weather.temperature.toString();

    return Card(
      elevation: 7,
      // margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: ClipPath(
        clipper: ShapeBorderClipper(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Stack(
          children: [
            WeatherBg(
              weatherType: weatherBackgroud(weather.weatherMain.toString()),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 15, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formatter.format(weather.date!).toString(),
                        textAlign: TextAlign.left,
                        style: whiteTextStyle.copyWith(
                            fontSize: 15, fontWeight: semiBold),
                      ),
                      Text(
                        formatterTime.format(weather.date!).toString(),
                        textAlign: TextAlign.left,
                        style: whiteTextStyle.copyWith(
                            fontSize: 15, fontWeight: semiBold),
                      ),
                    ],
                  ),
                  Text(
                    "${temperature.substring(0, temperature.indexOf('C'))}\u2103",
                    textAlign: TextAlign.left,
                    style: whiteTextStyle.copyWith(
                        fontSize: 15, fontWeight: semiBold),
                  ),
                ],
              ),
            ),
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
