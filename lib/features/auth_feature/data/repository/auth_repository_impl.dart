import 'package:dartz/dartz.dart';
import 'package:ramzino/core/errors/failure.dart';
import 'package:ramzino/core/params/user_parms.dart';
import 'package:ramzino/features/auth_feature/data/data_source/auth_local_data_source.dart';

import 'package:ramzino/features/auth_feature/data/models/user_model.dart';

import 'package:ramzino/features/auth_feature/domain/repository/auth_repository.dart';
import 'package:local_auth/local_auth.dart';
import '../../../../core/errors/exceptions.dart';

class AuthRepositoryImpl extends AuthRepository {
  // final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final LocalAuthentication authentication;
  AuthRepositoryImpl(
      {required this.authentication, required this.localDataSource});

  /// Login Implementation
  @override
  Future<Either<Failure, UserModel>> login(UserParams params) async {
    try {
      final localData = await localDataSource.login(params);
      return Right(localData);
    } on WrongPasswordException {
      return Left(WrongPasswordFailure(
          errorMessage: 'کاربری با این مشخصات وجود ندارد'));
    }
  }

  /// register Implementation

  @override
  Future<Either<Failure, bool>> registerUser(UserParams params) async {
    try {
      final localData = await localDataSource.register(params);
      return Right(localData);
    } on UserExistException {
      return Left(UserExistFailure(
          errorMessage: 'قبلابا این نام کاربری ثبت نام کرده اید'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> fingerPrintLogin(
      LocalAuthentication auth) async {
    try {
      final authentication = await localDataSource.fingerLogin(auth);
      return Right(authentication);
    } on AuthException {
      print('kir khari');
      return Left(AuthFailure(errorMessage: 'ناموفق'));
    }
  }

  /// Fingerprint Login Implementation
}

/*
class AuthRepositoryImpl extends AuthRepository {
  final AuthLocalDataSource authLocalDataSource;

  AuthRepositoryImpl({required this.authLocalDataSource});

  @override
  Future<Either<Failure, bool>> login(LoginEntity loginEntity) async {
    // TODO: implement login
    try {
      final loginModel = LoginModel(loginEntity.username, loginEntity.password);
      final userLogin = await authLocalDataSource.login(loginModel);
      return Right(userLogin);
    } on WrongPasswordException {
      return Left(WrongPasswordFailure(errorMessage: 'wrong password'));
    }
  }

  @override
  Future<Either<Failure, bool>> register(RegisterEntity registerEntity) async {
    // TODO: implement register
    try {
      final registerModel = RegisterModel(
          username: registerEntity.username,
          password: registerEntity.password,
          confirmPassword: registerEntity.confirmPassword);
      final userRegister = await authLocalDataSource.register(registerModel);
      return Right(userRegister);
    } on WeakPasswordException {
      return Left(WeakPasswordFailure(errorMessage: 'weak password'));
    }
  }
}*/
