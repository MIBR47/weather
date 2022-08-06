import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:weather_application/Service/filter_argument.dart';

import '../theme.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController weatherController = TextEditingController(text: '');
  var selectedIndex = 0;
  String selectedChip = '';

  @override
  initState() {
    super.initState();
  }

  // This function is called whenever the text field changes
  _runFilter(String enteredKeyword) async {
    String key = "e253b441ac228c01226cb2ddbecfded4";
    Weather? _data;
    late WeatherFactory ws;
    ws = WeatherFactory(key);
    Weather weather = await ws.currentWeatherByCityName(enteredKeyword);
    Navigator.of(context).pushReplacementNamed(
      '/filter',
      arguments: filterArguments(weather),
    );
    // Navigator.of(context)
    //     .pushReplacementNamed('/dashboard', arguments: weather);
  }

  @override
  Widget build(BuildContext context) {
    Widget searchbar() {
      return Padding(
        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
        child: TextField(
          controller: weatherController,
          autofocus: true,
          onSubmitted: (value) async {
            await _runFilter(value);
          },
          // onChanged: (value) => _runFilter(value),
          decoration: InputDecoration(
              hintText: "Search...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              suffixIcon: Icon(
                Icons.search,
                color: Colors.blueAccent,
              )),
        ),
      );
    }

    Widget body() {
      return Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.95,
          // margin: EdgeInsets.only(top: 30),
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                width: MediaQuery.of(context).size.width * 0.90,
                child: Column(
                  children: [
                    searchbar(),
                    // filtercard(),
                    // cardlist(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              // header(),
              body(),
            ],
          ),
        ),
      ),
    );
  }
}
