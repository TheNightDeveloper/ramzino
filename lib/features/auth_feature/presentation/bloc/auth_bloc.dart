import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:ramzino/core/params/user_parms.dart';
import 'package:ramzino/features/auth_feature/domain/entity/user_entity.dart';
import 'package:ramzino/features/auth_feature/domain/use_case/auth_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase authUseCase;

  AuthBloc({required this.authUseCase}) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoadingState());
        final failureOrUserCredential =
            await authUseCase.login(event.userParams);

        emit(failureOrUserCredential.fold(
            (fail) => ErrorAuthState(message: fail.errorMessage),
            (userEntity) => SignedInState(userEntity)));
      } else if (event is RegisterEvent) {
        emit(LoadingState());
        final failureOrUserCredential =
            await authUseCase.register(event.userParams);
        emit(failureOrUserCredential.fold(
            (fail) => ErrorAuthState(message: fail.errorMessage),
            (userEntity) => SignedUpState()));
        // emit(eitherToState(failureOrUserCredential, SignedUpState()));
      } else if (event is FingerPrintAuthEvent) {
        emit(LoadingState());
        final failureOrUserCredential =
            await authUseCase.fingerPrintLogin(event.auth);
       emit(failureOrUserCredential.fold(
            (fail) => ErrorAuthState(message: fail.errorMessage),
            (userEntity) => SignedInState(userEntity)));
      }
    });
  }
}
