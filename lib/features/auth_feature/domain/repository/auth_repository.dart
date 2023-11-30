import 'package:dartz/dartz.dart';
import 'package:local_auth/local_auth.dart';
import 'package:ramzino/core/params/user_parms.dart';
import '../../../../core/errors/failure.dart';
import '../entity/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(UserParams params);
  Future<Either<Failure, bool>> registerUser(UserParams params);
  Future<Either<Failure, UserEntity>> fingerPrintLogin(LocalAuthentication auth);

}
