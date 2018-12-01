import 'dart:developer';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_2/pages/loader.dart';
import 'package:weather_app_2/pages/no_location.dart';
import 'package:weather_app_2/pages/weather_page.dart';
import 'package:weather_app_2/utils/connection_utils.dart';
import 'package:weather_app_2/utils/custome_route.dart';
import 'package:weather_app_2/utils/location_utils.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: WeatherHome(),
    );
  }
}

class WeatherHome extends StatefulWidget {
  @override
  _WeatherHomeState createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  LocationUtils locationUtils = LocationUtils();
  ConnectionUtils connectionUtils = ConnectionUtils();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.wait([
      locationUtils.checkPermission(),
      connectionUtils.checkConnectvity()
    ]).then((res) {
//      debugger();
      print(res);
      if (res[0] == GeolocationStatus.granted &&
          res[1] != ConnectivityResult.none) {
        locationUtils.getLocation().then((pos) {
          Navigator.pushReplacement(
              context,
              MyCustomRoute(
                  builder: (context) => WeatherPage(
                        position: pos,
                      )));
        });
      } else {
        Navigator.pushReplacement(
            context,
            MyCustomRoute(
                builder: (context) => NoLocation(
                      askForPermission: res[0] == GeolocationStatus.denied,
                    )));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Loader();
  }
}
