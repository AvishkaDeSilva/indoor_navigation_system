import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indoor_navigation_system/logic_layer/blocs/map_bloc.dart';
import 'package:indoor_navigation_system/logic_layer/events/map_event.dart';
import 'package:indoor_navigation_system/logic_layer/states/map_state.dart';

class MainScreen extends StatelessWidget {
  static const String id = 'main_screen';
  final Offset _currentLocation = const Offset(0.0, 0.0);
  final double _scaleFactor = 1.0;
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: DropdownButton(
          items: const [
            DropdownMenuItem(
              value: 0,
              child: Text("A"),
            ),
            DropdownMenuItem(
              value: 1,
              child: Text("B"),
            ),
            DropdownMenuItem(
              value: 2,
              child: Text("C"),
            ),
            DropdownMenuItem(
              value: 3,
              child: Text("D"),
            ),
            DropdownMenuItem(
              value: 4,
              child: Text("E"),
            ),
            DropdownMenuItem(
              value: 5,
              child: Text("F"),
            ),
            DropdownMenuItem(
              value: 6,
              child: Text("G"),
            ),
            DropdownMenuItem(
              value: 7,
              child: Text("H"),
            ),
            DropdownMenuItem(
              value: 8,
              child: Text("I"),
            ),
            DropdownMenuItem(
              value: 9,
              child: Text("J"),
            ),
            DropdownMenuItem(
              value: 10,
              child: Text("K"),
            ),
            DropdownMenuItem(
              value: 11,
              child: Text("L"),
            ),
            DropdownMenuItem(
              value: 12,
              child: Text("M"),
            ),
          ],
          onChanged: (value) {
            final bloc = context.read<MapBloc>();
            bloc.add(GetDestinationLocationEvent(value: value ?? 0));
          },
        ),
        title: const Center(child: Text('Map Screen')),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FittedBox(
              child: BlocConsumer<MapBloc, MapState>(
                  listener: (context, state) {
                    if (state is LoadingNavigationState) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) {
                          return const AlertDialog(
                            title: Center(
                              child: Text(
                                'Loading..!!',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                            ),
                            content: Center(child: CircularProgressIndicator()),
                            elevation: 3,
                            scrollable: true,
                            actionsAlignment: MainAxisAlignment.center,
                          );
                        },
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is InitialMapState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is LoadedMapState || state is LoadingNavigationState) {
                      return SizedBox(
                        height: state.image.height.toDouble(),
                        width: state.image.width.toDouble(),
                        child: CustomPaint(
                          painter:
                              MapLocationPainter(state.image, _scaleFactor),
                        ),
                      );
                    } else if (state is LoadedNavigationState) {
                      Navigator.pop(context);
                      return SizedBox(
                        height: state.image.height.toDouble(),
                        width: state.image.width.toDouble(),
                        child: CustomPaint(
                          painter: MapPathPainter(
                              state.image, state.navigatePath, _scaleFactor),
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  })),
        ),
      ),
    );
  }
}

// class MainScreen extends StatefulWidget {
//   static const String id = 'main_screen';
//   const MainScreen({super.key});
//
//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }
//
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
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Center(child: Text('Map Screen')),
//       ),
//       body: SizedBox(
//         height: MediaQuery. of(context). size. height,
//         width: MediaQuery. of(context). size. width,
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: FittedBox(
//             child: SizedBox(
//               height: _image.height.toDouble(),
//               width: _image.width.toDouble(),
//               child: CustomPaint(
//                 painter: MapPainter(_image, _currentLocation, _scaleFactor),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class MapLocationPainter extends CustomPainter {
  final Offset _location = const ui.Offset(215, 8);
  final double _scaleFactor;
  final ui.Image _image;

  MapLocationPainter(this._image, this._scaleFactor);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawImage(_image, const Offset(0, 0), Paint());

    var locationPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    var mappedLocation =
        Offset(_location.dx * _scaleFactor, _location.dy * _scaleFactor);
    canvas.drawCircle(mappedLocation, 5.0, locationPaint);
  }

  @override
  bool shouldRepaint(MapLocationPainter oldDelegate) =>
      oldDelegate._location != _location;
}

class MapPathPainter extends CustomPainter {
  final Offset _location = const ui.Offset(215, 8);
  final double _scaleFactor;
  final ui.Image _image;
  final List<List<double>> _path;

  MapPathPainter(this._image, this._path, this._scaleFactor);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawImage(_image, const Offset(0, 0), Paint());

    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    Path path = Path();
    path.addPolygon(
        _path.map((innerList) => Offset(innerList[0], innerList[1])).toList(),
        false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(MapPathPainter oldDelegate) =>
      oldDelegate._location != _location;
}

Offset calculateLocation(List<Beacon> beacons) {
  // Implementation to calculate the location based on the readings from the nearest 3 beacons
  // ...
  return const Offset(0.0, 0.0);
}
