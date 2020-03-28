import 'package:flutter/material.dart';
import 'Response/IndiaResponse.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class India extends StatefulWidget {
  @override
  _IndiaState createState() => _IndiaState();
}

class _IndiaState extends State<India> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getIndiaStats(),
      builder: (context, snapshot){

        print('http.Response: '+snapshot.data.toString());

        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }else {

          IndiaResponse indiaResponse = IndiaResponse.fromJson(jsonDecode(snapshot.data));

          return ListView.builder(
              shrinkWrap: true,
              itemCount: indiaResponse.data.statewise.length+1,
              itemBuilder: (context, index){

                if(index==0) {

                  String confirmed = indiaResponse.data.total.confirmed.toString();
                  String recovered = indiaResponse.data.total.recovered.toString();
                  String deaths = indiaResponse.data.total.deaths.toString();
                  String active = indiaResponse.data.total.active.toString();

                  String date_time = indiaResponse.data.lastRefreshed.toString();
                  String day = DateTime.parse(date_time).day.toString();
                  String month = DateTime.parse(date_time).month.toString();
                  String year = DateTime.parse(date_time).year.toString();
                  String date = day + '-' + month + '-'+ year;
                  String hour = DateTime.parse(date_time).hour.toString();
                  String min = DateTime.parse(date_time).minute.toString();
                  String time = hour + ':' + min;

                  return Card(
                    color: Colors.black,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: <Widget>[
                          Container(alignment: Alignment.center, padding: EdgeInsets.all(5), child: Text('Total', style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold))),
                          Divider(color: Colors.white,),
                          Container(alignment: Alignment.center,padding: EdgeInsets.all(5), child: Text('Updated on ' + date +' at '+time, style: TextStyle(fontSize: 16, color: Colors.white))),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(alignment: Alignment.topLeft, child: Text('Confirmed: ' + confirmed, style: TextStyle(fontSize: 18, color: Colors.white))),
                                Container(alignment: Alignment.topLeft, child: Text('Recovered: ' + recovered, style: TextStyle(fontSize: 18, color: Colors.blue[200]))),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(alignment: Alignment.topLeft, child: Text('Deaths: ' + deaths, style: TextStyle(fontSize: 18, color: Colors.red[200]))),
                                Container(alignment: Alignment.topLeft, child: Text('Active: ' + active, style: TextStyle(fontSize: 18, color: Colors.green[200]))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }else {

                  String state = indiaResponse.data.statewise[index-1].state;
                  String confirmed = indiaResponse.data.statewise[index-1].confirmed.toString();
                  String recovered = indiaResponse.data.statewise[index-1].recovered.toString();
                  String deaths = indiaResponse.data.statewise[index-1].deaths.toString();
                  String active = indiaResponse.data.statewise[index-1].active.toString();

                  return Card(
                    color: Colors.white,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: <Widget>[
                          Container(alignment: Alignment.center,
                              child: Text(
                                  state, style: TextStyle(fontSize: 22))),
                          Divider(),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(alignment: Alignment.topLeft,
                                    child: Text('Confirmed: ' + confirmed,
                                        style: TextStyle(fontSize: 18))),
                                Container(alignment: Alignment.topLeft,
                                    child: Text('Recovered: ' + recovered,
                                        style: TextStyle(fontSize: 18,
                                            color: Colors.blue[600]))),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(alignment: Alignment.topLeft,
                                    child: Text('Deaths: ' + deaths,
                                        style: TextStyle(fontSize: 18,
                                            color: Colors.red[600]))),
                                Container(alignment: Alignment.topLeft,
                                    child: Text('Active: ' + active,
                                        style: TextStyle(fontSize: 18,
                                            color: Colors.green[600]))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

              }
          );
        }
      },
    );
  }

  Future<dynamic> getIndiaStats() async {

    http.Response response = await http.get('https://api.rootnet.in/covid19-in/unofficial/covid19india.org/statewise');

    return response.body;
  }

}