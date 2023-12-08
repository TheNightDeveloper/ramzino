part of 'password_bloc.dart';

abstract class PasswordEvent {}

class LoadingEvent extends PasswordEvent {}

class AddPasswordEvent extends PasswordEvent {
  final PasswordParams passwordParams;
  AddPasswordEvent(this.passwordParams);
}

class DeletePasswordEvent extends PasswordEvent {
  final String passID;
  DeletePasswordEvent({required this.passID});
}

class UpdatePasswordEvent extends PasswordEvent {
  final PasswordParams passwordParams;
  UpdatePasswordEvent(this.passwordParams);
}

class SortPasswordEvent extends PasswordEvent {}

class GetAllPasswordsEvent extends PasswordEvent {}

class DarkModeSwitchEvent extends PasswordEvent {}

class AddToMostUseEvent extends PasswordEvent {
  final String passId;
  AddToMostUseEvent({required this.passId});
}
