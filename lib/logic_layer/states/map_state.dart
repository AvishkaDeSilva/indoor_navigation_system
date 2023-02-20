import 'dart:ui' as ui;

import 'package:equatable/equatable.dart';
import 'package:indoor_navigation_system/logic_layer/states/map_state.dart';
abstract class MapState extends Equatable{
  get image => null;
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
  final double locationX;
  final double locationY;

  LoadedCurrentLocationState({required this.locationX, required this.locationY});
  @override
  List<Object?> get props => [locationX,locationY];
}

class FailedCurrentLocationState extends MapState{
  @override
  List<Object?> get props => [];
}

class LoadingNavigationState extends MapState{
  @override
  final ui.Image image;
  LoadingNavigationState({required this.image});
  @override
  List<Object?> get props => [image];
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