import 'package:dartz/dartz.dart';
import 'package:local_auth/local_auth.dart';
import 'package:ramzino/core/params/user_parms.dart';
import 'package:ramzino/features/auth_feature/domain/entity/user_entity.dart';

import 'package:ramzino/features/auth_feature/domain/repository/auth_repository.dart';

import '../../../../core/errors/failure.dart';

class AuthUseCase {
  final AuthRepository repository;
  const AuthUseCase(this.repository);
  Future<Either<Failure, bool>> register(UserParams userParams) async {
    return await repository.registerUser(userParams);
  }

  Future<Either<Failure, UserEntity>> login(UserParams userParams) async {
    return await repository.login(userParams);
  }
  Future<Either<Failure, UserEntity>> fingerPrintLogin(LocalAuthentication auth) async {
    return await repository.fingerPrintLogin(auth);
  }

}
