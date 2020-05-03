//Helped with initial server connection: https://medium.com/@suragch/minimal-client-server-example-for-flutter-and-node-js-3e1b376f1093

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ServerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Node server demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(
            title:
                Text('COVID-19 Network', style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.white,
            elevation: 0),
        body: BodyWidget(),
      ),
    );
  }
}

class BodyWidget extends StatefulWidget {
  @override
  BodyWidgetState createState() {
    return new BodyWidgetState();
  }
}

class BodyWidgetState extends State<BodyWidget> {
  Position _currentPosition;

  Map<String, dynamic> list;
  String uidata = "";
  String uidatalat = "";
  String uidatalong = "";
  String uidatasick = "";

  bool isSwitched = true;
  String sickindicator = "yes";

//for initState to update, you need to hot reload with green button
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();

    //making patch requests every 5 seconds
    const fiveSeconds = const Duration(seconds: 1); //I can change this to milliseconds: 250 or something
    Timer.periodic(fiveSeconds, (Timer t) => _makePatchRequest());
    Timer.periodic(fiveSeconds, (Timer t) => _makeGetRequest());
    Timer.periodic(fiveSeconds, (Timer t) => _warnFunc());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          //width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(children: <Widget>[
                ToggleSwitch(
                  minWidth: 90.0,
                  initialLabelIndex: 2,
                  //activeBgColor: Colors.redAccent,
                  activeTextColor: Colors.white,
                  inactiveBgColor: Colors.grey,
                  inactiveTextColor: Colors.grey[900],
                  activeColors: [Colors.red, Colors.green],
                  labels: ['Sick', 'Healthy'],
                  icons: [Icons.warning, Icons.check],
                  onToggle: (index) {
                    //print('switched to: $index');
                    var sicklist = ["yes", "no"];
                    sickindicator = sicklist[index];
                  },
                  activeBgColor: null,
                ),
              ]),

              /*
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    'ID: $uidata \n Lat: $uidatalat \n Long: $uidatalong \n Sick Status: $uidatasick'),
              ),
              */

              Padding(padding: EdgeInsets.only(top: 50)),
              Text(diagnostic, style: TextStyle(color: _colorFunc(), fontWeight: FontWeight.bold, fontSize: 30)),
              Padding(padding: EdgeInsets.only(top: 30)),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _colorFunc(),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 100)),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "My current position: \n LAT ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}",
                      textAlign: TextAlign.center,
                    ),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    Text(
                      "Other person's position: \n LAT $uidatalat, LNG: $uidatalong",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    geolocator
        .getPositionStream(LocationOptions(
            accuracy: LocationAccuracy.best, timeInterval: 1000))
        .listen((position) {
      setState(() {
        _currentPosition = position;
      });
    });
  }

  //https://stackoverflow.com/questions/52575602/how-to-go-on-about-receiving-json-array-in-flutter-and-parsing-it

  String diagnostic = "";

  _warnFunc() async {
    double distanceInMeters = await Geolocator().distanceBetween(
        double.parse(uidatalat),
        double.parse(uidatalong),
        _currentPosition.latitude,
        _currentPosition.longitude);

    //need to implement distance thing and also figure out latency issue
    if (uidatasick == "yes") {
      //(distanceInMeters < 60000.0) { //if 6 meters away or closer, return red as warning!!! //https://medium.com/swlh/working-with-geolocation-and-geocoding-in-flutter-and-integration-with-maps-16fb0bc35ede
      return diagnostic = "Warning!";
    } else {
      return diagnostic = "No warning...";
    }
  }

  _colorFunc() {
    if (diagnostic == "Warning!") {
      return Colors.red;
    } else {
      return Colors.blue;
    }
  }

  _makeGetRequest() async {
    Response response = await get(_localhost());

    int x;
    if (Platform.isAndroid)
      x = 1;
    else
      x = 0;

    String receivedJson = response.body;
    //print(receivedJson);
    setState(() {
      list = json.decode(receivedJson);
      //print(list["data"][0]);
      uidata = list["data"][x]["_id"].toString();
      uidatalat = list["data"][x]["lat"].toString();
      uidatalong = list["data"][x]["long"].toString();
      uidatasick = list["data"][x]["sick"].toString();
    });

    //print("$uidatalong, $uidatalat");
  }

  //can update current location for user 5eadc0e7ca5ba9393e50fd44
  _makePatchRequest() async {
    Map<String, String> headers = new Map<String, String>();
    headers.putIfAbsent("Content-Type", () => "application/json");
    String jsonbody = jsonEncode({
      "sick": sickindicator,
      "lat": _currentPosition.latitude,
      "long": _currentPosition.longitude,
    });

    String url;
    if (Platform.isAndroid)
      url =
          'http://10.0.2.2:7000/api/contacts/5eadbfe8ca5ba9393e50fd43'; //Android would patch to first user
    else // for iOS simulator
      url =
          'http://localhost:7000/api/contacts/5eadc0e7ca5ba9393e50fd44'; //ios would patch to second - see how the urls are different?

    Response response = await patch(url, headers: headers, body: jsonbody);

    print(response.body);
  }

  String _localhost() {
    if (Platform.isAndroid)
      return 'http://10.0.2.2:7000/api/contacts';
    else // for iOS simulator
      return 'http://localhost:7000/api/contacts';
  }
}
