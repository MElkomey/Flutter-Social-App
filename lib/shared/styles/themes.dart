import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme=ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primarySwatch: Colors.blue,
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    titleSpacing: 20,
    color: Colors.white,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    titleTextStyle: TextStyle(
        color: Colors.black87,
        fontSize: 25,
        fontWeight: FontWeight.bold,
        fontFamily: 'Jannah'
    ),
  ),bottomNavigationBarTheme: BottomNavigationBarThemeData(
  type: BottomNavigationBarType.fixed,
  selectedItemColor: Colors.blue,
  unselectedItemColor: Colors.grey,
  backgroundColor: Colors.white,
  elevation: 20,

),
  textTheme: TextTheme(
    bodyText1: TextStyle(
        color: Colors.black87,
        fontSize: 25,
        fontWeight: FontWeight.bold,
        fontFamily: 'Jannah'
    ),
    bodyText2: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'Jannah',
    ),
  ),
  iconTheme: IconThemeData(
    color: Colors.blue,
  ),
  fontFamily: 'Jannah'
);

