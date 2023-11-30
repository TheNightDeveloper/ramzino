part of 'welcome_bloc.dart';

abstract class WelcomeEvent {}

class Trigger extends WelcomeEvent {
  final int index;

  Trigger(this.index);
}
