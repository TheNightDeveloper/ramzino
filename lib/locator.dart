import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';
import 'package:ramzino/features/auth_feature/data/data_source/auth_local_data_source.dart';
import 'package:ramzino/features/auth_feature/data/repository/auth_repository_impl.dart';
import 'package:ramzino/features/auth_feature/domain/repository/auth_repository.dart';
import 'package:ramzino/features/auth_feature/domain/use_case/auth_usecase.dart';
import 'package:ramzino/features/auth_feature/presentation/bloc/auth_bloc.dart';
import 'package:ramzino/features/pasword_feature/business/repositories/Passwords_repository.dart';
import 'package:ramzino/features/pasword_feature/business/usecases/passwords_uscase.dart';
import 'package:ramzino/features/pasword_feature/data/datasources/passwords_local_data_source.dart';
import 'package:ramzino/features/pasword_feature/data/repositories/passwords_repository_impl.dart';
import 'package:ramzino/features/pasword_feature/skeleton/page_resources.dart';

GetIt locator = GetIt.instance;
depInjSetup() {
  // DataSources
  locator.registerSingleton<AuthLocalDataSource>(AuthLocalDataSourceImpl());
  locator
      .registerSingleton<PasswordsLocalDatabase>(PasswordsLocalDatabaseImpl());

  ///
  locator.registerSingleton<LocalAuthentication>(LocalAuthentication());

  /// Repositorys
  locator.registerSingleton<AuthRepository>(AuthRepositoryImpl(
      localDataSource: locator(), authentication: locator()));
  locator.registerSingleton<PasswordsRepository>(
      PasswordsRepositoryImpl(locator()));

  /// Use-Case
  locator.registerSingleton<AuthUseCase>(AuthUseCase(locator()));
  // locator.registerLazySingleton(() => AddPassword(locator()));
  // locator.registerLazySingleton(() => DeletePassword(locator()));
  // locator.registerLazySingleton(() => GetAllPasswords(locator()));
  // locator.registerLazySingleton(() => UpdatePassword(locator()));

  locator
      .registerSingleton<GetAndSortPasswords>(GetAndSortPasswords(locator()));
  locator.registerSingleton<AddPassword>(AddPassword(locator()));
  locator.registerSingleton<DeletePassword>(DeletePassword(locator()));
  locator.registerSingleton<UpdatePassword>(UpdatePassword(locator()));
    locator.registerSingleton<MostUsePassword>(MostUsePassword(locator()));


  // locator.registerSingleton<UseCase>(DeletePassword(locator()));
  // locator.registerSingleton<UseCase>(GetAllPasswords(locator()));
  // locator.registerSingleton<UseCase>(UpdatePassword(locator()));

  /// Bloc
  locator.registerSingleton<AuthBloc>(AuthBloc(authUseCase: locator()));
  locator.registerSingleton<PasswordBloc>(PasswordBloc(
      addPassword: locator(),
      getAndSortPasswords: locator(),
      deletePassword: locator(),
      updatePassword: locator(),
      mostUsePassword: locator()));
}
