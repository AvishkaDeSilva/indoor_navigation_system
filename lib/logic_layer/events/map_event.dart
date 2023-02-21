import 'package:indoor_navigation_system/logic_layer/events/map_event.dart';

abstract class MapEvent{}

class LoadMapEvent extends MapEvent{
  final String imagePath;
  LoadMapEvent({required this.imagePath});

}

class StartNavigationEvent extends MapEvent{
  final int end;
  StartNavigationEvent({required this.end});
}

class ShowDestinationPathLocationEvent extends MapEvent{
  final int start;
  final int end;
  ShowDestinationPathLocationEvent({required this.start,required this.end});
}

