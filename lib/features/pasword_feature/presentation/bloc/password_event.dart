part of 'password_bloc.dart';


abstract class PasswordEvent {}
class LoadingEvent extends PasswordEvent{}

class AddPasswordEvent extends PasswordEvent {
  final PasswordParams passwordParams;
  AddPasswordEvent(this.passwordParams);
}
class DeletePasswordEvent extends PasswordEvent {
  final int index;
  DeletePasswordEvent(this.index);
}
class UpdatePasswordEvent extends PasswordEvent {
  final int index;
  UpdatePasswordEvent(this.index);
}
class SortPasswordEvent extends PasswordEvent{
  
}
class GetAllPasswordsEvent extends PasswordEvent {}
class DarkModeSwitchEvent extends PasswordEvent{}
