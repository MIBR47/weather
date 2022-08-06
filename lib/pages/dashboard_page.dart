import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';
import 'package:weather/weather.dart';
import 'package:intl/intl.dart';
import 'package:weather_application/theme.dart';
import 'package:weather_application/widget/menu_card.dart';
import 'package:weather_application/widget/weather_forecast_card.dart';
// enum weatherCondition{cloud.png,};

class DashboardPage extends StatefulWidget {
  DashboardPage({Key? key}) : super(key: key);

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
    Weather5days();
    super.initState();
  }

  Weather5days() async {
    /// Removes keyboard
    // FocusScope.of(context).requestFocus(FocusNode());
    String key = "e253b441ac228c01226cb2ddbecfded4";
    double lat = -6.245185939299144;
    double lon = 106.96004566267743;
    String cityName = 'bekasi';
    wf = WeatherFactory(key);
    List<Weather> weather = await wf.fiveDayForecastByLocation(lat, lon);
    Weather weather2 = await wf.currentWeatherByCityName(cityName);
    setState(() {
      print(weather2);
      _listDataWeather = weather;
      // print(_listDataWeather);
      // _state = AppState.FINISHED_DOWNLOADING;
    });
  }

  @override
  Widget build(BuildContext context) {
    // WeatherFactory wf = WeatherFactory(key);
    // late Weather? data = _data;
    final data = ModalRoute.of(context)?.settings.arguments as Weather;

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
                            data.areaName.toString(),
                            textAlign: TextAlign.left,
                            style: whiteTextStyle.copyWith(
                                fontSize: 20, fontWeight: semiBold),
                          ),
                          Text(
                            formatter.format(data.date!).toString(),
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
              temperature: data.temperature.toString(),
            ),
            SizedBox(
              width: 10,
            ),
            WeatherCard(
              weather: data.weatherMain.toString(),
            ),
          ],
        ),
      );
    }

    Widget header() {
      return Stack(
        children: [
          WeatherBg(
            weatherType: WeatherType.thunder,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.45,
          ),
          Container(
            // decoration: const BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage('assets/header.png'),
            //     fit: BoxFit.fill,
            //   ),
            // ),
            child: Column(
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                  child: Padding(
                    padding: EdgeInsets.only(left: 22, right: 22, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/dashboard_logo.png',
                              color: whiteColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Dashboard',
                              style: whiteTextStyle.copyWith(
                                  fontSize: 22, fontWeight: semiBold),
                            ),
                          ],
                        ),
                      ],
                    ),
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
          ),
        ],
      );
    }

    Widget card() {
      return Container(
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
                child: weatherForecastCard(weather: _listDataWeather[index]),
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
                  'Attendance History',
                  style: trueBlackTextStyle.copyWith(
                      fontSize: 16, fontWeight: semiBold),
                ),
                InkWell(
                  child: Text(
                    // '${authProvider.user.access_token}',
                    'See all',
                    style: trueBlackTextStyle.copyWith(
                        fontSize: 14, fontWeight: light),
                  ),
                  onTap: () {
                    // attendanceHandler();
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
