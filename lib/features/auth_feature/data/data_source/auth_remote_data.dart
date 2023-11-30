// import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
// import 'package:ramzino/core/errors/exceptions.dart';
// import 'package:ramzino/features/auth_feature/data/models/user_model.dart';

// import '../../../../core/params/user_parms.dart';

// abstract class AuthRemoteDataSource {
//   Future<UserModel> login(UserParams userParams);
//   Future<UserModel> register(UserParams userParams);
// }

// class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
//   @override
//   Future<UserModel> login(UserParams userParams) async {
//     var user =
//         ParseUser(userParams.username, userParams.password, userParams.username);
//     var response = await user.login();
//     if (response.success) {
//       // return const UserModel().copyWith(
//       //     username: user.username,
//       //     password: user.password,
//       //     email: user.emailAddress);
//     } else {
//       throw ServerException();
//     }
//   }

//   @override
//   Future<UserModel> register(UserParams userParams) async {
//     var user = ParseUser.createUser(
//         userParams.username, userParams.password, userParams.email);
//     var response = await user.signUp();
//     if (response.success) {
//       return const UserModel().copyWith(
//           username: user.username,
//           password: user.password,
//           email: user.emailAddress);
//     } else {
//       throw ServerException();
//     }
//   }
// }
