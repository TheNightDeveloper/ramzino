import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:ramzino/core/errors/exceptions.dart';
import 'package:ramzino/core/params/user_parms.dart';
import 'package:ramzino/core/utils/const.dart';
import 'package:ramzino/features/auth_feature/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<UserModel> login(UserParams userParams);
  Future<bool> register(UserParams userParams);
  Future<UserModel> fingerLogin(LocalAuthentication auth);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static String _getUserPrefKey(String userName) => '$USER_KEY$userName';

  @override
  Future<bool> register(UserParams userParams) async {
    try {
      UserModel userModel = UserModel(
          username: userParams.username!, password: userParams.password!);
      final userJsonString = userModel.toJsonString();
      if (await secureStorage.containsKey(key: 'USER')) {
        throw UserExistException();
      } else {
        await secureStorage.write(key: 'USER', value: userJsonString);
        return true;
      }
      // return true;
    } catch (e) {
      print(e);
      throw UserExistException();
    }
  }

  @override
  Future<UserModel> login(UserParams userParams) async {
    try {
      var userModel;
      final userJsonString = await secureStorage.read(key: 'USER');
      var model = UserModel.fromJsonString(userJsonString!);
      if (model.username == userParams.username &&
          model.password == userParams.password) {
        print(userJsonString);
        userModel = model;
      }
      return userModel;
    } catch (e) {
      print(e);
      throw WrongPasswordException();
    }
  }

  @override
  Future<UserModel> fingerLogin(LocalAuthentication auth) async {
    var userModel;
    bool canCheckBiometrices =
        await auth.canCheckBiometrics || await auth.isDeviceSupported();
    try {
      if (!canCheckBiometrices) throw PlatformException;
      var authentication = await auth.authenticate(
        localizedReason: 'Please verify your fingerprint to login ',
        options:
            const AuthenticationOptions(stickyAuth: true, biometricOnly: true),
      );
      if (authentication) {
        final userJsonString = await secureStorage.read(key: 'USER');
        if (userJsonString != null) {
          print(userJsonString);
          userModel = UserModel.fromJsonString(userJsonString);
        }
      } else {
        print('injas');
        throw AuthException();
      }
      return userModel;
    } catch (e) {
      print(e);
      throw AuthException();
    }
  }
}



  // @override
  // Future<UserModel> login(UserParams userParams) async {
  //   try {
  //     var userModel;
  //     String? storedUsername = await secureStorage.read(key: 'username');
  //     // String? storedEmail = await secureStorage.read(key:'email');
  //     String? storedPassword = await secureStorage.read(key: 'password');
  //     if (userParams.username == storedUsername &&
  //         userParams.password == storedPassword) {
  //       userModel = const UserModel().copyWith(
  //         username: storedUsername,
  //         password: storedPassword,
  //       );
  //     }
  //     // else{
  //     //    throw WrongPasswordException();
  //     // }
  //     return userModel;
  //   } catch (e) {
  //     print('wrong pass');
  //     throw WrongPasswordException();
  //   }
  // }

//   @override
//   Future<bool> register(UserParams userParams) async {
//     try {
//       await secureStorage.write(key: 'username', value: userParams.username);
//       await secureStorage.write(key: 'email', value: userParams.email);
//       await secureStorage.write(key: 'password', value: userParams.password);
//       return true;
//     } catch (e) {
//       print(e);
//       return false;
//     }
//   }
// }



  /*
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  @override
  Future<bool> login(LoginModel loginModel) async {
    // TODO: implement login
    String savedUsername = await sharedPreferencesService.getString('username');
    String savedPassword = await sharedPreferencesService.getString('password');
    return (loginModel.username == savedUsername &&
        loginModel.password == savedPassword);
  }

  @override
  Future<bool> register(RegisterModel registerModel) async {
    // TODO: implement register
    bool registerUsername = await sharedPreferencesService.setString(
        'username', registerModel.username);
    bool registerPassword = await sharedPreferencesService.setString(
        'password', registerModel.password);
    return (registerUsername && registerPassword);
  }
}
*/
