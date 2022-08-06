import 'package:flutter/material.dart';
import 'package:weather_application/pages/dashboard_page.dart';

import 'pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
      theme: ThemeData(
        disabledColor: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        '/splash': (context) => SplashPage(),
        '/dashboard': (context) => DashboardPage(),
      },
    );
  }
}
