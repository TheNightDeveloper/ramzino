abstract class Failure {
  final String errorMessage;
  const Failure({required this.errorMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required String errorMessage})
      : super(errorMessage: errorMessage);
}

class WrongPasswordFailure extends Failure {
  WrongPasswordFailure({required String errorMessage})
      : super(errorMessage: errorMessage);
}

class UserExistFailure extends Failure {
  UserExistFailure({required String errorMessage})
      : super(errorMessage: errorMessage);
}
class AuthFailure extends Failure {
  AuthFailure({required String errorMessage})
      : super(errorMessage: errorMessage);
}

class DatabaseFailure extends Failure {
  DatabaseFailure({required String errorMessage})
      : super(errorMessage: errorMessage);
}
