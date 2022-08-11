import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_application/provider/weather_Provider.dart';

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

  ///Untuk mendapatkan data cuaca dari nama kota yang dimasukan
  getWeatherBycityName(String enteredKeyword) async {
    await Provider.of<WeatherProvider>(context, listen: false)
        .getWeatherByCityName(enteredKeyword);

    if (mounted) {
      Navigator.of(context).pushReplacementNamed(
        '/filter',
      );
    } else {
      AlertDialog alert = AlertDialog(
        title: const Text('Something went Wrong'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Try again?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('cancel'),
          ),
          TextButton(
            onPressed: () {
              getWeatherBycityName(enteredKeyword);
              Navigator.pop(context);
            },
            child: const Text('Try again'),
          ),
        ],
      );
      showDialog(context: context, builder: (context) => alert);
    }
  }

  @override
  void dispose() {
    weatherController.dispose();
    super.dispose();
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
            var connectivityResult = await (Connectivity().checkConnectivity());
            if (connectivityResult == ConnectivityResult.mobile ||
                connectivityResult == ConnectivityResult.wifi) {
              await getWeatherBycityName(value);
            } else if (connectivityResult == ConnectivityResult.none) {
              AlertDialog alert = AlertDialog(
                title: const Text('Something went Wrong'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: const <Widget>[
                      Text('No internet Access.'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('cancel'),
                  ),
                ],
              );
              showDialog(context: context, builder: (context) => alert);
            }
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
