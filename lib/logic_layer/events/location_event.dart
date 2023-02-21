import 'package:equatable/equatable.dart';
import 'package:indoor_navigation_system/data_layer/models/map.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class StartScanning extends LocationEvent {}

class StopScanning extends LocationEvent {}

class UpdateLocation extends LocationEvent {
  final Location location;

  const UpdateLocation(this.location);

  @override
  List<Object> get props => [location];
}


