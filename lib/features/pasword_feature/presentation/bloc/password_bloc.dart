import 'package:equatable/equatable.dart';
import 'package:ramzino/core/params/password_params.dart';
import 'package:ramzino/features/pasword_feature/business/entities/password_entity.dart';
import 'package:ramzino/features/pasword_feature/business/usecases/passwords_uscase.dart';
import 'package:ramzino/features/pasword_feature/skeleton/page_resources.dart';

part 'password_event.dart';
part 'password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  final GetAndSortPasswords getAndSortPasswords;
  final AddPassword addPassword;
  final DeletePassword deletePassword;
  final UpdatePassword updatePassword;
  final MostUsePassword mostUsePassword;

  PasswordBloc(
      {required this.deletePassword,
      required this.updatePassword,
      required this.getAndSortPasswords,
      required this.addPassword,
      required this.mostUsePassword})
      : super(PasswordState()) {
    on<PasswordEvent>((event, emit) async {
      if (event is AddPasswordEvent) {
        //  Adding Password
        emit(LoadingState());
        final failureOrList = await addPassword(params: event.passwordParams);
        emit(failureOrList.fold(
            (fail) => ErrorState(message: fail.errorMessage),
            (added) => PasswordAddedState()));
      } else if (event is DeletePasswordEvent) {
        //  Deleting Password
        emit(LoadingState());
        final failureOrSuccess = await deletePassword(params: event.passID);
        emit(failureOrSuccess.fold(
            (fail) => ErrorState(message: fail.errorMessage),
            (deleted) => PasswordDeletedState()));
      } else if (event is UpdatePasswordEvent) {
        emit(LoadingState());
        final failureOrSuccess =
            await updatePassword(params: event.passwordParams);
        emit(failureOrSuccess.fold(
            (fail) => ErrorState(message: fail.errorMessage),
            (deleted) => PasswordUpdatedState()));
      } else if (event is GetAllPasswordsEvent) {
        emit(LoadingState());
        final failureOrList = await getAndSortPasswords();
        emit(failureOrList.fold(
            (fail) => ErrorState(message: fail.errorMessage),
            (map) => PasswordState.copyWith(map)));
        // TODO Getting Password
      } else if (event is DarkModeSwitchEvent) {
        // TODO Getting Password
      } else if (event is AddToMostUseEvent) {
        emit(LoadingState());
        final failureOrSuccess = await mostUsePassword(params: event.passId);
        emit(failureOrSuccess.fold(
          (fail) => ErrorState(message: fail.errorMessage),
          (success) => AddToMostUseState(),
        ));
      }
    });
  }
}
