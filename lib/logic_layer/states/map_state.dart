import 'dart:ui' as ui;

import 'package:equatable/equatable.dart';
import 'package:indoor_navigation_system/logic_layer/states/map_state.dart';

import '../../data_layer/models/map.dart';
abstract class MapState extends Equatable{
  get image => null;
  get location => null;
}

class InitialMapState extends MapState {
  @override
  List<Object?> get props => [];
}

class LoadedMapState extends MapState{
  @override
  final ui.Image image;
  LoadedMapState({required this.image});
  @override
  List<Object?> get props => [image];
}

class LoadingCurrentLocationState extends MapState{
  @override
  List<Object?> get props => [];
}

class LoadedCurrentLocationState extends MapState{
  @override
  final Location location;

  LoadedCurrentLocationState({required this.location});
  @override
  List<Object?> get props => [location];
}

class FailedCurrentLocationState extends MapState{
  @override
  List<Object?> get props => [];
}

class LoadingNavigationState extends MapState{
  @override
  final ui.Image image;
  @override
  final Location location;
  LoadingNavigationState({required this.image,required this.location});
  @override
  List<Object?> get props => [image,location];
}

class LoadedNavigationState extends MapState{
  @override
  final ui.Image image;
  final List<List<double>> navigatePath;

  LoadedNavigationState({required this.image,required this.navigatePath});
  @override
  List<Object?> get props => [image,navigatePath];
}

class FailedNavigationState extends MapState{
  @override
  List<Object?> get props => [];
}

class NavigateState extends MapState{
  @override
  final ui.Image image;
  final List<List<double>> navigatePath;

  NavigateState({required this.image,required this.navigatePath});
  @override
  List<Object?> get props => [image,navigatePath];
}

class ReachedLocationState extends MapState{
  @override
  final ui.Image image;
  @override
  final Location location;
  ReachedLocationState({required this.image,required this.location});
  @override
  List<Object?> get props => [image,location];
}