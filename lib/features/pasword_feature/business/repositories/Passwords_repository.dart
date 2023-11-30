import 'package:dartz/dartz.dart';
import 'package:ramzino/core/errors/failure.dart';
import 'package:ramzino/core/params/password_params.dart';

import '../entities/password_entity.dart';

abstract class PasswordsRepository {
  Future<Either<Failure, bool>> addPassword({
    required PasswordParams passwordParams,
  });
  Future<Either<Failure, bool>> deletePassword({
    required int index,
  });
  Future<Either<Failure, bool>> updatePassword({
    required int index,
  });
  Future<Either<Failure, Map<String, List<PasswordEntity>>>>
      getAndSortPasswords();
}
