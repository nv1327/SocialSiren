

//Next: Getting the distance between coordinates
//This plugin also allows us to calculate the distance between two coordinates as:
//double distanceInMeters = await Geolocator().distanceBetween(52.2165157, 6.9437819, 52.3546274, 4.8285838);
//from https://medium.com/swlh/working-with-geolocation-and-geocoding-in-flutter-and-integration-with-maps-16fb0bc35ede






import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Position _currentPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_currentPosition != null)
              Text(
                  "LAT ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}"),
            MaterialButton(
              elevation: 5,
              color: Colors.blue,
              child: Text("Get location"),
              onPressed: () {
                // Get location here
                _getCurrentLocation();
              },
            ),
          ],
        ),
      ),
    );
  }

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    //this one is much better because this geolocator livestreams data
    //to test, just run the app and then click on the emulator
    //go to features > location > freeway drive, which will simulate a moving car
    //then, click get location and it will livestream the data
    geolocator
        .getPositionStream(LocationOptions(
            accuracy: LocationAccuracy.best, timeInterval: 1000))
        .listen((position) {
      setState(() {
        _currentPosition = position;
      });
    });
    /*
    //this geolocator is a single reload which is ok
    geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best).then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });*/
  }
}
