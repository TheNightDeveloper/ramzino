import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String username;
  // final int id;
  final String password;
  const UserEntity(
      {required this.username, required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [username, password];
}
