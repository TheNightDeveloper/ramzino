part of 'main_bloc.dart';

abstract class MainEvent {}

class Trigger extends MainEvent {
  final int index;
  Trigger(this.index);
}
