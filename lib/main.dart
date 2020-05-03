

/*so you have to follow this and add the geolocator tags to platform specific files (Android/app/src/profile/AndroidManifest.xml and ios/Runner/Info.plist),
but then stop running the app and go to terminal and run "flutter run" to add those platform-specific files -
a hot reload or restart won't be enough!*/
//Issue: https://github.com/flutter/flutter/issues/10912
//Guide: https://alligator.io/flutter/geolocator-plugin/
//Helped with livestreaming: https://medium.com/swlh/working-with-geolocation-and-geocoding-in-flutter-and-integration-with-maps-16fb0bc35ede

import 'package:coronaproject/server_page.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ServerPage(), //HomePage()
    );
  }
}