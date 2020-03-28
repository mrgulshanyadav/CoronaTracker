import 'dart:async';
import 'dart:typed_data';

import 'package:corona/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isSplashTimeOut;

  startTimer() async {
    new Timer(Duration(seconds: 3), (){
      setState(() {
        isSplashTimeOut = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    isSplashTimeOut = false;
    startTimer();
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
      home: isSplashTimeOut? Home() : Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: FutureBuilder(
            future: getMaskUsageTipsImage(),
            builder: (context, snapshot){

              if(!snapshot.hasData){
                return Center(child: CircularProgressIndicator(),);
              }else{
                print(snapshot.data);
                List<int> list = snapshot.data.toString().codeUnits;
                Uint8List bytes = Uint8List.fromList(list);

                return Container(
                  child: Image.memory(bytes),
                );
              }
            },
          )
        ),
      ),
    );
  }

  Future<dynamic> getMaskUsageTipsImage() async {

    Map<String, String> requestHeaders = {
      'Content-type': 'image/jpeg',
      'x-rapidapi-host': 'coronavirus-monitor.p.rapidapi.com',
      'x-rapidapi-key': '7f2e5d6204mshd06cf5aa1786578p1257e0jsn204c97056783',
    };

    http.Response response = await http.get('https://coronavirus-monitor.p.rapidapi.com/coronavirus/masks.php', headers: requestHeaders);

    return response.body;
  }

}
