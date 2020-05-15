import 'package:flutter/material.dart';

import 'theme/colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.now();
    bool isDay = dateTime.hour < 21;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              decorationColor: Colors.white,
              displayColor: Colors.white,
            ),
        fontFamily: 'OpenSans',
        canvasColor:
            !isDay ? AppColors.themeColorLight : AppColors.themeColorDark,
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
          elevation: 0,
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
