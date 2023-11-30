part of 'auth_bloc.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final UserParams userParams;
  LoginEvent({required this.userParams});
}

class RegisterEvent extends AuthEvent {
  final UserParams userParams;
  RegisterEvent({required this.userParams});
}

class FingerPrintAuthEvent extends AuthEvent {
  final LocalAuthentication auth;
  FingerPrintAuthEvent({required this.auth});
}
