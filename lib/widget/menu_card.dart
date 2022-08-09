import 'package:flutter/material.dart';
import 'package:weather_application/theme.dart';

class TemperatureCard extends StatelessWidget {
  final double? temperature;
  const TemperatureCard({required this.temperature, Key? key})
      : super(key: key);

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
              offset: const Offset(0, 5), // changes position of shadow
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
                  // "${temperature.toString().substring(0, temperature.toString().indexOf('C'))}\u2103",
                  '$temperature \u2103',
                  style: trueBlackTextStyle.copyWith(
                      fontSize: 28, fontWeight: semiBold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ElseCard extends StatelessWidget {
  final String data;
  final String name;
  final double fontsize;
  const ElseCard(
      {required this.data,
      Key? key,
      required this.name,
      required this.fontsize})
      : super(key: key);

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
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                name,
                style: trueBlackTextStyle.copyWith(
                    fontSize: 12, fontWeight: semiBold),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  data,
                  style: trueBlackTextStyle.copyWith(
                      fontSize: fontsize, fontWeight: semiBold),
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
  final String weather;
  const WeatherCard({required this.weather, Key? key}) : super(key: key);

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
              offset: const Offset(0, 5), // changes position of shadow
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
