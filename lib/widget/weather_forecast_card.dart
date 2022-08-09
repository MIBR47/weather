import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:intl/intl.dart';
import 'package:weather_application/model/forecast_Daily_Model.dart';
import 'package:weather_application/theme.dart';

class WeatherForecastCard extends StatelessWidget {
  // final ForecastModel weather;
  final ForecastDailyModel daily;
  const WeatherForecastCard({Key? key, required this.daily}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('E, dd MMM yyyy');
    String temperature = daily.temp.toString();

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
              weatherType: weatherBackgroud(daily.weather![0].mainWeather!),
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
                        formatter
                            .format(DateTime.fromMillisecondsSinceEpoch(
                                daily.dt * 1000))
                            .toString(),
                        textAlign: TextAlign.left,
                        style: whiteTextStyle.copyWith(
                            fontSize: 15, fontWeight: semiBold),
                      ),
                      Text(
                        daily.weather![0].mainWeather!,
                        textAlign: TextAlign.left,
                        style: whiteTextStyle.copyWith(
                            fontSize: 15, fontWeight: semiBold),
                      ),
                    ],
                  ),
                  Text(
                    '$temperature \u2103',
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
