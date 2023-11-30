import 'package:dartz/dartz.dart';
import 'package:ramzino/core/errors/exceptions.dart';
import 'package:ramzino/core/errors/failure.dart';
import 'package:ramzino/core/params/password_params.dart';
import 'package:ramzino/features/pasword_feature/business/repositories/Passwords_repository.dart';
import 'package:ramzino/features/pasword_feature/data/datasources/passwords_local_data_source.dart';
import 'package:ramzino/features/pasword_feature/data/models/password_model.dart';
import 'package:ramzino/features/pasword_feature/skeleton/page_resources.dart';

class PasswordsRepositoryImpl implements PasswordsRepository {
  final PasswordsLocalDatabase _database;
  PasswordsRepositoryImpl(this._database);

  @override
  @override
  Future<Either<Failure, bool>> addPassword(
      {required PasswordParams passwordParams}) async {
    try {
      var password = PasswordModel(
          id: passwordParams.id,
          username: passwordParams.username,
          password: passwordParams.password,
          describtion: passwordParams.describtion,
          title: passwordParams.title,
          type: passwordParams.type);
      return Right(await _database.addToDB(password));
    } on DataBaseException {
      return Left(
          DatabaseFailure(errorMessage: 'عملیات اضافه کردن ناموفق بود'));
    }
  }

  @override
  Future<Either<Failure, bool>> deletePassword({required int index}) async {
    try {
      return Right(await _database.deletePassword(index));
    } on DataBaseException {
      return Left(DatabaseFailure(errorMessage: 'عملیات حذف ناموفق بود'));
    }
  }

  @override
  Future<Either<Failure, Map<String, List<PasswordModel>>>>
      getAndSortPasswords() async {
    try {
      var passList = await _database.getAllPasswords();
      Map<String, List<PasswordModel>> allPass = {
        'All': [],
        'Social': [],
        'CreditCard': [],
        'WebSite': [],
        'Other': [],
      };
      for (var pass in passList) {
        allPass['All']!.add(pass);
        if (pass.type == PasswordType.creditCard) {
          allPass['CreditCard']?.add(pass);
        } else if (pass.type == PasswordType.other) {
          allPass['Other']?.add(pass);
        } else if (pass.type == PasswordType.webSite) {
          allPass['WebSite']?.add(pass);
        } else if (pass.type == PasswordType.social) {
          allPass['Social']?.add(pass);
        }
      }
      return Right(allPass);
    } on DataBaseException {
      return Left(DatabaseFailure(errorMessage: 'عملیات بارگذاری ناموفق بود'));
    }
  }

  @override
  Future<Either<Failure, bool>> updatePassword({required int index}) {
    // TODO: implement updatePassword
    throw UnimplementedError();
  }
}
