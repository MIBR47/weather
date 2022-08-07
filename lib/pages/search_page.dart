import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:weather_application/Service/filter_argument.dart';

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
    late WeatherFactory ws;
    ws = WeatherFactory(key);
    //  await ws.currentWeatherByCityName(enteredKeyword) == ws,.??

    Weather weather = await ws.currentWeatherByCityName(enteredKeyword);

    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacementNamed(
      '/filter',
      arguments: FilterArguments(weather),
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
              suffixIcon: const Icon(
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
