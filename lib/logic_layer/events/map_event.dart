import 'package:indoor_navigation_system/logic_layer/events/map_event.dart';

abstract class MapEvent{}

class LoadMapEvent extends MapEvent{
  final String imagePath;
  LoadMapEvent({required this.imagePath});

}

class GetCurrentLocationEvent extends MapEvent{}

class GetDestinationLocationEvent extends MapEvent{
  final int value;
  GetDestinationLocationEvent({required this.value});
}

