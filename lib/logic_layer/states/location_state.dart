import 'package:equatable/equatable.dart';
import 'package:indoor_navigation_system/data_layer/models/map.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationUpdated extends LocationState {
  final Location location;

  const LocationUpdated(this.location);

  @override
  List<Object> get props => [location];
}