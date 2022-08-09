import 'package:flutter/material.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';
import 'package:weather/weather.dart';
import 'package:weather_application/model/forecast_Model.dart';
import 'package:weather_application/theme.dart';
import 'package:weather_application/widget/weather_forecast_card.dart';

class WeatherListPage extends StatelessWidget {
  final ForecastModel listDataWeather;
  const WeatherListPage({required this.listDataWeather, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget card() {
      return Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.90,
            height: MediaQuery.of(context).size.height * 1.5,
            child: ListView.builder(
              itemCount: listDataWeather.daily?.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                // final weather = _listDataWeather[index];
                return LazyLoadingList(
                  initialSizeOfItems: 5,
                  index: index,
                  hasMore: true,
                  // ignore: avoid_print
                  loadMore: () => print('Loading More'),
                  child: WeatherForecastCard(
                    daily: listDataWeather.daily![index],
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

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar(
            toolbarHeight: 120,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            iconTheme: const IconThemeData(color: Colors.black),
            centerTitle: true,
            backgroundColor: Colors.white,
            bottomOpacity: 0.0,
            elevation: 0.0,
            title: Text(
              '5 Day Weather Forecast',
              style: trueBlackTextStyle.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ),
        backgroundColor: whiteColor,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                card(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
