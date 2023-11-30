part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  final UserEntity? userEntity;
  const AuthState({this.userEntity});
  @override
  List<Object?> get props => [userEntity];
}

class AuthInitial extends AuthState {}

class LoadingState extends AuthState {}

class SignedInPageState extends AuthState {}

class LoggedOutState extends AuthState {}
class FingerPrintAuthState extends AuthState{}
class SignedInState extends AuthState {
  const SignedInState(UserEntity userEntity) : super(userEntity: userEntity);
}

class SignedUpState extends AuthState {}

class ErrorState extends AuthState {}

class ErrorAuthState extends AuthState {
  final String message;
  ErrorAuthState({required this.message});
}
