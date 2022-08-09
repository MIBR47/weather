import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:weather_application/pages/dashboard_page.dart';
import 'package:weather_application/pages/filter_page.dart';
import 'package:weather_application/provider/weather_Provider.dart';

import 'argument/Dashboard_argument.dart';
import 'pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => WeatherProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashPage(),
        theme: ThemeData(
          disabledColor: Colors.blue,
        ),
        initialRoute: "/",
        routes: {
          '/splash': (context) => const SplashPage(),
          '/dashboard': (context) => DashboardPage(
              ModalRoute.of(context)!.settings.arguments as DashboardArguments),
          '/filter': (context) => const FilterPage(),
        },
        onGenerateRoute: ((settings) {
          switch (settings.name) {
            case '/dashboard':
              return PageTransition(
                  child: DashboardPage(ModalRoute.of(context)!
                      .settings
                      .arguments as DashboardArguments),
                  type: PageTransitionType.bottomToTop);
            default:
              return null;
          }
        }),
      ),
    );
  }
}
