import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:indoor_navigation_system/data_layer/models/map.dart';

import '../events/location_event.dart';
import '../states/location_state.dart';


class LocationBloc extends Bloc<LocationEvent, LocationState> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  late StreamSubscription<ScanResult> scanSubscription;
  List<Beacon> beacons = [];

  LocationBloc() : super(LocationInitial());

  @override
  Stream<LocationState> mapEventToState(LocationEvent event) async* {
    if (event is StartScanning) {
      yield* _mapStartScanningToState();
    } else if (event is StopScanning) {
      yield* _mapStopScanningToState();
    }
  }

  Stream<LocationState> _mapStartScanningToState() async* {
    yield LocationLoading();

    scanSubscription = flutterBlue.scan().listen((scanResult) {
      // Retrieve beacon information
      beacons.add(Beacon(rssi: scanResult.rssi));
    });
    // Determine user's location
    var location = determineLocation(beacons);

    // Update user's location
    add(UpdateLocation(location));
  }

  Stream<LocationState> _mapStopScanningToState() async* {
    flutterBlue.stopScan();
    scanSubscription.cancel();
  }

  Location determineLocation(List<Beacon> beacons) {
    if (beacons.length < 3) {
      return Location(x: 0, y: 0);
    }

    // Calculate the intersection of three circles
    int x1 = beacons[0].x;
    int y1 = beacons[0].y;
    int x2 = beacons[1].x;
    int y2 = beacons[1].y;
    int x3 = beacons[2].x;
    int y3 = beacons[2].y;
    int r1 = beacons[0].distance;
    int r2 = beacons[1].distance;
    int r3 = beacons[2].distance;

    int A = 2 * (x2 - x1);
    int B = 2 * (y2 - y1);
    int C = r1 * r1 - r2 * r2 - x1 * x1 + x2 * x2 - y1 * y1 + y2 * y2;
    int D = 2 * (x3 - x2);
    int E = 2 * (y3 - y2);
    int F = r2 * r2 - r3 * r3 - x2 * x2 + x3 * x3 - y2 * y2 + y3 * y3;
    double x = (C * E - F * B) / (E * A - B * D);
    double y = (C * D - A * F) / (B * D - A * E);

    return Location(x: x, y: y);
  }
}
