import 'package:corona/home.dart';
import 'package:flutter/material.dart';
import 'package:startapp/startapp.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  void showAd() async {
    await StartApp.showInterstitialAd();
  }

  @override
  void initState() {

    showAd();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Corona Tracker',
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.blue
      ),
      home: Home(), // homepage class
    );
  }
}