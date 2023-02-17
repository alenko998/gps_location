// ignore: prefer_const_constructors
// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables, unused_local_variable, avoid_print
// ignore: prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gps_location/api/location_api.dart';
import 'package:gps_location/data_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // location
  Position? location;
  Position? position;
  // api data
  int id = 1;
  double? latitude;
  double? longitude;
  @override
  void initState() {
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      if (position != null) {
        setState(() {
          location = position;
          latitude = position.latitude;
          longitude = position.longitude;
        });
        sendLocation(id, latitude, longitude);
      }

      print(position == null
          ? 'Unknown'
          : '${position.latitude.toString()}, ${position.longitude.toString()} koordinate: $latitude i $longitude');
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get GPS Location"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(location == null ? '' : location.toString()),
          MaterialButton(
            color: Colors.blue,
            onPressed: () async {
              LocationPermission checkPermission =
                  await Geolocator.checkPermission();
              if (checkPermission == LocationPermission.denied ||
                  checkPermission == LocationPermission.deniedForever) {
                LocationPermission permission =
                    await Geolocator.requestPermission();
                print(permission);
              }
              if (checkPermission == LocationPermission.whileInUse ||
                  checkPermission == LocationPermission.always) {
                position = await Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.high);
                setState(() {
                  location = position;
                  latitude = location!.latitude;
                  longitude = location!.longitude;
                });
              }
            },
            child: Text("Get Location"),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => DataPage()));
            },
            child: Text("See Data"),
          )
        ],
      )),
    );
  }
}
