import 'package:flutter/material.dart';
import 'package:weather_app/screen/main_page.dart';
import 'package:weather_app/utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Тестовое задание: Простейший API клиент погоды с BLoC',
      theme: ThemeData(

        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: RoutesHelper.routeHome,
      routes: {
        RoutesHelper.routeHome: (ctx) => MainPage(),
      },
    );
  }
}
