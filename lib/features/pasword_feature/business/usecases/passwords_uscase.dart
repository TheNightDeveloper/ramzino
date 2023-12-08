import 'package:dartz/dartz.dart';
import 'package:ramzino/core/errors/failure.dart';
import 'package:ramzino/core/params/password_params.dart';
import 'package:ramzino/features/pasword_feature/business/entities/password_entity.dart';
import 'package:ramzino/features/pasword_feature/business/repositories/Passwords_repository.dart';

abstract class UseCase<Type, Params> {
  Future<Type> call({Params params});
}

/// ADD PASSWORD USECASE
class AddPassword implements UseCase<Either<Failure, bool>, PasswordParams> {
  final PasswordsRepository _passwordsRepository;
  AddPassword(this._passwordsRepository);
  @override
  Future<Either<Failure, bool>> call({PasswordParams? params}) async {
    return await _passwordsRepository.addPassword(passwordParams: params!);
  }
}

/// DELETE PASSWORD USECASE
class DeletePassword implements UseCase<Either<Failure, bool>, String> {
  final PasswordsRepository _passwordsRepository;
  DeletePassword(this._passwordsRepository);
  @override
  Future<Either<Failure, bool>> call({String? params}) async {
    return await _passwordsRepository.deletePassword(passID: params!);
  }
}

/// UPDATE PASSWORD USECASE
class UpdatePassword implements UseCase<Either<Failure, bool>, PasswordParams> {
  final PasswordsRepository _passwordsRepository;
  UpdatePassword(this._passwordsRepository);
  @override
  Future<Either<Failure, bool>> call({PasswordParams? params}) async {
    return await _passwordsRepository.updatePassword(passwordParams: params!);
  }
}

/// GET ALL PASSWORD IN LIST
class GetAndSortPasswords
    implements
        UseCase<Either<Failure, Map<String, List<PasswordEntity>>>, void> {
  final PasswordsRepository _passwordsRepository;
  GetAndSortPasswords(this._passwordsRepository);
  @override
  Future<Either<Failure, Map<String, List<PasswordEntity>>>> call(
      {void params}) {
    return _passwordsRepository.getAndSortPasswords();
  }
}

class MostUsePassword implements UseCase<Either<Failure, bool>, String> {
  final PasswordsRepository _passwordsRepository;
  MostUsePassword(this._passwordsRepository);
  @override
  Future<Either<Failure, bool>> call({String? params}) async {
    return await _passwordsRepository.mostUse(passId: params!);
  }
}
