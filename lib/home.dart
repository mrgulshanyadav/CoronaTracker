import 'package:corona/global.dart';
import 'package:corona/india.dart';
import 'package:corona/total.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Corona Tracker'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: 'Home',),
              Tab(text: 'India',),
              Tab(text: 'Global',),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Total(),
            India(),
            Global(),
          ],
        ),
      )
    );
  }
}
