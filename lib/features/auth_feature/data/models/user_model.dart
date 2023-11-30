import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:ramzino/features/auth_feature/domain/entity/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  final String username;
  // final int id;
  final String password;
  const UserModel(
      {required this.username, required this.password})
      : super(username: username, password: password);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
  String toJsonString() => jsonEncode(toJson());
  static UserModel fromJsonString(String jsonString) =>
      UserModel.fromJson(jsonDecode(jsonString));
}
