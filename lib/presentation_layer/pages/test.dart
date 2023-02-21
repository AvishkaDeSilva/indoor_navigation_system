import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:geolocator/geolocator.dart';

class Test extends StatefulWidget {
  static const String id = 'test_screen';
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  String _indoorLocation = 'Unknown';
  late StreamSubscription<RangingResult> _streamRanging;

  @override
  void initState() {
    super.initState();

    // Configure the Flutter Beacon package
    flutterBeacon.initializeScanning;

    // Start listening to Bluetooth beacon signals
    _streamRanging = flutterBeacon.ranging([Region(
      identifier: '1111',
      proximityUUID: '042d20ba-6546-439f-baf8-7a4ac1a113b8',
        major: 1,
        minor: 1
    )]
    ).listen(_onRanging);
  }

  @override
  void dispose() {
    super.dispose();

    // Stop listening to Bluetooth beacon signals
    _streamRanging?.cancel();
  }

  void _onRanging(RangingResult result) async {
    // Get the list of beacons in range
    final beacons = result.beacons;

    // If there are no beacons in range, set the indoor location to Unknown
    if (beacons.isEmpty) {
      setState(() {
        _indoorLocation = 'Unknown';
      });
      return;
    }

    // Calculate the distance to each beacon in range
    final distances = beacons.map((beacon) => beacon.accuracy).toList();

    // Calculate the weighted average of the distances
    final weights = distances.map((distance) => 1 / (distance * distance)).toList();
    final totalWeight = weights.fold(0, (sum, weight) => sum.toInt() + weight.toInt());
    final averageDistance = weights.fold(0, (sum, weight) => sum.toInt() + weight.toInt() * totalWeight) / (totalWeight * totalWeight);

    // Use the Geolocator package to get the user's current GPS location
    final position = await Geolocator.getCurrentPosition();

    // Update the indoor location based on the calculated distance and GPS location
    setState(() {
      _indoorLocation = _calculateIndoorLocation(averageDistance, position);
    });
  }

  String _calculateIndoorLocation(double distance, Position position) {
    // Use the distance and GPS location to determine the user's indoor location
    // You can replace this with your own algorithm for determining the indoor location
    return 'Location: ${distance.toStringAsFixed(2)} meters from beacon\nGPS: ${position.latitude.toStringAsFixed(6)}, ${position.longitude.toStringAsFixed(6)}';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Indoor Location'),
        ),
        body: Center(
          child: Text(_indoorLocation),
        ),
      ),
    );
  }
}
