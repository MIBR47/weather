import 'package:flutter/material.dart';
import 'package:weather_application/theme.dart';

class TemperatureCard extends StatelessWidget {
  String temperature;
  TemperatureCard({required this.temperature, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        // padding: EdgeInsets.all(25),
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: whiteColor,
          border: Border.all(color: whiteColor, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // IconButton(
              //   icon: Icon(Icons.sunny),
              //   iconSize: 66,
              //   onPressed: () {},
              // ),
              // SizedBox(
              //   height: 2,
              // ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "${temperature.substring(0, temperature.indexOf('C'))}\u2103",
                  style: trueBlackTextStyle.copyWith(
                      fontSize: 32, fontWeight: semiBold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherCard extends StatelessWidget {
  String weather;
  WeatherCard({required this.weather, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        // padding: EdgeInsets.all(25),
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: whiteColor,
          border: Border.all(color: whiteColor, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // IconButton(
              //   icon: Icon(Icons.sunny),
              //   iconSize: 66,
              //   onPressed: () {},
              // ),
              // SizedBox(
              //   height: 2,
              // ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Image.asset(
                      weatherImage(weather),
                      // color: whiteColor,
                      height: 70,
                      width: 70,
                    ),
                    Text(
                      weather,
                      style: trueBlackTextStyle.copyWith(
                          fontSize: 15, fontWeight: semiBold),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

String weatherImage(String weather) {
  String image;

  switch (weather) {
    case "Clear":
      image = 'assets/sun.png';
      break;
    case "Clouds":
      image = 'assets/cloud.png';
      break;
    case "Rain":
      image = 'assets/rain.png';
      break;
    case "Drizzle":
      image = 'assets/Drizzle.png';
      break;
    case "Thunderstorm":
      image = 'assets/storm.png';
      break;
    case "Snow":
      image = 'assets/snow.png';
      break;
    default:
      image = 'assets/sun.png';
  }

  return image;
}
