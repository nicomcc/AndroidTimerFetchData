import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
//  const fiveSeconds = const Duration(seconds: 5);
//  Timer.periodic(oneSecond, (Timer t) => getData());
//  Timer.periodic(Duration(seconds: 10), (timer) {
//    //print(DateTime.now());
//    fetchPatientCount();
//  });
  runApp(new MaterialApp(
    home: new HomePage(),
  ));
}

//Future<String> fetchPatientCount() async {
//  print(DateTime.now().toIso8601String());
//  return DateTime.now().toIso8601String();
//}
//
//Future<String> getData() async {
//  http.Response response = await http.get(
//    Uri.encodeFull(
//        "https://www.random.org/cgi-bin/randbyte?nbytes=64&format=h"),
//  );
//
//  print(response.body);
//  return response.body;
//}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  String data = "";
  String _now;
  Timer _everySecond;
  Timer _every20Second;

  @override
  void initState() {
    super.initState();
    getData();
    // sets first value
    _now = DateTime.now().second.toString();

    // defines a timer
    _everySecond = Timer.periodic(Duration(seconds: 1), (Timer t) {
      TimeOfDay timeOfDay = TimeOfDay.fromDateTime(DateTime.now());
      String res = timeOfDay.format(context);
      bool is12HoursFormat = res.contains(new RegExp(r'[A-Z]'));
      setState(() {
        _now = res + ':' + DateTime.now().second.toString();
      });
    });

    _every20Second = Timer.periodic(Duration(seconds: 20), (Timer t) {
      getData();
    });
  }

  Future<String> getData() async {
    http.Response response = await http.get(
      Uri.encodeFull(
          "https://www.random.org/cgi-bin/randbyte?nbytes=64&format=h"),
    );
    setState(() {
      data = response.body;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Timer App'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            _now,
            textAlign: TextAlign.center,
            style: TextStyle(height: 5, fontSize: 45),
          ),
          Text(
            data,
            textAlign: TextAlign.center,
            style: TextStyle(height: 5, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
