import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';
import 'package:weather/weather.dart';
import 'package:intl/intl.dart';
import 'package:weather_application/Service/Dashboard_argument.dart';
import 'package:weather_application/pages/search_page.dart';
import 'package:weather_application/pages/splash_page.dart';
import 'package:weather_application/pages/weather_forecast_list_pages.dart';
import 'package:weather_application/theme.dart';
import 'package:weather_application/widget/menu_card.dart';
import 'package:weather_application/widget/weather_forecast_card.dart';
import 'package:page_transition/page_transition.dart';

// enum weatherCondition{cloud.png,};

class DashboardPage extends StatefulWidget {
  DashboardArguments arguments;
  DashboardPage(this.arguments, {Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final DateFormat formatter = DateFormat('E, dd MMM yyyy');
  late WeatherFactory wf;
  List<Weather> _listDataWeather = [];
  Future? _initFuture;

  @override
  void initState() {
    Weather5days(widget.arguments.position);
    super.initState();
  }

  Weather5days(Position position) async {
    /// Removes keyboard
    // FocusScope.of(context).requestFocus(FocusNode());
    String key = "e253b441ac228c01226cb2ddbecfded4";
    double lat = position.latitude;
    double lon = position.longitude;
    String cityName = 'bekasi';
    wf = WeatherFactory(key);
    List<Weather> weather = await wf.fiveDayForecastByLocation(lat, lon);
    // Weather weather2 = await wf.currentWeatherByCityName(cityName);
    setState(() {
      // print(weather2);
      _listDataWeather = weather;
      // print(_listDataWeather);
      // _state = AppState.FINISHED_DOWNLOADING;
    });
  }

  @override
  Widget build(BuildContext context) {
    // WeatherFactory wf = WeatherFactory(key);
    // late Weather? data = _data;
    final data =
        ModalRoute.of(context)?.settings.arguments as DashboardArguments;
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

    Widget search() {
      return InkWell(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.90,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 56,
          child: TextField(
            readOnly: true,
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.bottomToTop,
                  child: const SearchPage(),
                ),
              );
            },
            // obscureText: true,
            decoration: InputDecoration(
              hintText: "Search...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              suffixIcon: Icon(
                Icons.search,
                color: Colors.blueAccent,
              ),
              // suffixIconColor: primaryBlue,
              // labelText: 'Try Chiropractic',
              // labelStyle: TextStyle(
              //   color: grey,
              // ),
            ),
          ),
        ),
      );
    }

    Widget header() {
      return Stack(
        children: [
          WeatherBg(
            weatherType: weatherBackgroud(data.weather.weatherMain.toString()),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.45,
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
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: search(),
                ),
              ),
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

    Widget card() {
      return Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.90,
            height: MediaQuery.of(context).size.height * 0.4,
            child: ListView.builder(
              itemCount: _listDataWeather.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                // final weather = _listDataWeather[index];
                return Visibility(
                  visible: index < 5,
                  child: LazyLoadingList(
                    initialSizeOfItems: 5,
                    index: index,
                    hasMore: true,
                    loadMore: () => print('Loading More'),
                    child:
                        weatherForecastCard(weather: _listDataWeather[index]),
                  ),
                );

                // ignore: avoid_print
                // print(outlets);
                // // setState(() {});
                // return ShopCard(
                //   outlets,
                //   VisitPage(),
                // );
              },
            ),
          ),
        ],
      );
    }

    Widget listWeather() {
      return Container(
        width: MediaQuery.of(context).size.width * 0.85,
        margin: EdgeInsets.only(top: 22, bottom: 10),
        // height: 195,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '5 Day Weather Forecast',
                  style: trueBlackTextStyle.copyWith(
                      fontSize: 16, fontWeight: semiBold),
                ),
                InkWell(
                  child: Text(
                    'See All',
                    style: trueBlackTextStyle.copyWith(
                        fontSize: 14, fontWeight: light),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WeatherListPage(
                                  listDataWeather: _listDataWeather,
                                )));
                  },
                )
              ],
            ),
            card(),
          ],
        ),
      );
    }

    Widget body() {
      return Center(
        child: Column(
          children: [
            listWeather(),
            // visiting_list(),
          ],
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Wrap(
          children: [
            header(),
            body(),
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
