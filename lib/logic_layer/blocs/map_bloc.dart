import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indoor_navigation_system/data_layer/models/map.dart';
import '../states/map_state.dart';
import '../events/map_event.dart';
import 'dart:ui' as ui;

class MapBloc extends Bloc<MapEvent,MapState>{
  late ui.Image image;
  final Graph graph;
  MapBloc({required this.graph}):super(InitialMapState()){
    on<MapEvent>((event, emit) async{
      if (event is LoadMapEvent){
        emit(InitialMapState());
        ByteData data = await rootBundle.load(event.imagePath);
        final bytes = data.buffer.asUint8List();
        image = await decodeImageFromList(bytes);
        emit(LoadedMapState(image: image));
      }
      else if(event is ShowDestinationPathLocationEvent){
        emit(LoadingNavigationState(image: image, location: Location(x: 2,y: 3)));
        await Future.delayed(const Duration(seconds: 1));
        var paths = graph.shortestPath(event.start,event.end);
        emit(LoadedNavigationState(image: image,navigatePath: paths));
      }
    });
  }


}


// class _MainScreenState extends State<MainScreen> {
//   Offset _currentLocation = const Offset(0.0, 0.0);
//   final double _scaleFactor = 1.0;
//   late StreamSubscription<RangingResult> _ranging;
//   late ui.Image _image;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // flutterBeacon
//     //     .ranging([Region(identifier: 'FDC04B80-8AEA-4E58-8048-5AD6E5B567B0')])
//     //     .listen((result) {
//     //   if (result.beacons.isNotEmpty) {
//     //     var location = calculateLocation(result.beacons);
//     //     _updateLocation(location);
//     //   }
//     // });
//     load("assets/images/map.jpg");
//     print("YESSSSSSSSSSS");
//     startScanning();
//     print("NOOOOOOOOOOOOOOO");
//   }
//
//   void startScanning() async {
//     try {
//       await flutterBeacon.initializeScanning;
//       print('Beacon scanning has started');
//       final regions = <Region>[Region(identifier: 'Avishka',proximityUUID: '2a4b1e85-0f84-42ca-aae5-04bbb1f6f761')];
//
//       // Subscribe to the beacon data stream
//       flutterBeacon.ranging(regions).listen((RangingResult result) {
//         for (Beacon beacon in result.beacons) {
//           print('Beacon detected: ${beacon.proximityUUID} - ${beacon.accuracy}m');
//         }
//       });
//     } on Exception catch (e) {
//       print(e);
//     }
//   }
//
//   @override
//   void dispose() {
//     _ranging.cancel();
//     super.dispose();
//   }
//
//   void _updateLocation(Offset location) {
//     setState(() {
//       _currentLocation = location;
//     });
//   }
//
//   Future load(String asset) async {
//     ByteData data = await rootBundle.load(asset);
//     final bytes = data.buffer.asUint8List();
//     final image = await decodeImageFromList(bytes);
//     setState(() => _image = image);
//   }
