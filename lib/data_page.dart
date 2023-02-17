// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gps_location/api/location_api.dart';
import 'package:gps_location/model/coordinatesModel.dart';

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  Future<Coordinate>? coordinate;
  @override
  void initState() {
    coordinate = getCoordinate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Truck id: ${coordinate}"),
          Text("Truck coordinates: ${coordinate} ")
        ],
      )),
    );
  }
}
