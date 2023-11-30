import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramzino/features/auth_feature/presentation/screens/register_page.dart';
import 'package:ramzino/features/pasword_feature/presentation/pages/home_page.dart';
import 'package:ramzino/features/pasword_feature/presentation/pages/passwords_page.dart';
import 'package:ramzino/features/pasword_feature/presentation/pages/profile_page.dart';
import 'package:ramzino/features/pasword_feature/skeleton/bloc/main_bloc.dart';
import 'package:ramzino/locator.dart';
import '../../core/utils/const.dart';
import '../../features/Splash_feature/presentation/screens/splash_screen.dart';
import '../../features/Splash_feature/presentation/state_managment/splash_bloc.dart';
import '../../features/auth_feature/presentation/bloc/auth_bloc.dart';
import '../../features/auth_feature/presentation/screens/login_page.dart';
import '../../features/pasword_feature/presentation/bloc/password_bloc.dart';
import '../../features/pasword_feature/skeleton/main_page.dart';
import '../../features/welcome_feature/presentation/bloc/welcome_bloc.dart';
import '../../features/welcome_feature/presentation/screens/welcome_screen.dart';
import 'names.dart';

class AppPages {
  // return page entities
  static List<PageEntity> pages() {
    return [
      PageEntity(
          route: AppRoutes.initial,
          page: SplashScreen(),
          bloc: BlocProvider(create: (_) => SplashBloc())),
      PageEntity(
          route: AppRoutes.welcomePage,
          page: const WelcomePage(),
          bloc: BlocProvider(create: (_) => WelcomeBloc())),
      PageEntity(
          route: AppRoutes.loginPage,
          page: const LoginPage(),
          bloc: BlocProvider(create: (_) => locator<AuthBloc>())),
      PageEntity(
          route: AppRoutes.registerPage,
          page: const RegisterPage(),
          bloc: BlocProvider(create: (_) => locator<AuthBloc>())),
      PageEntity(
          route: AppRoutes.mainPage,
          page: const MainPage(),
          bloc: BlocProvider(create: (_) => MainBloc())),
      PageEntity(
          route: AppRoutes.homePage,
          page: const HomePage(),
          bloc: BlocProvider(create: (_) => locator<PasswordBloc>())),
      PageEntity(
          route: AppRoutes.passwordsPage,
          page: const PasswordsPage(),
          bloc: BlocProvider(create: (_) => locator<PasswordBloc>())),
      PageEntity(
          route: AppRoutes.profilePage,
          page: const ProfilePage(),
          bloc: BlocProvider(create: (_) => locator<PasswordBloc>()))
    ];
  }

  // return all bloc providers
  static List allBlocProviders(BuildContext context) {
    List blocProviders = [];
    for (var bloc in pages()) {
      if( !blocProviders.contains(bloc.bloc)){
        blocProviders.add(bloc.bloc) ;
      }


    }
    print(blocProviders);
    return blocProviders;
  }

  // return routes models for pages
  static MaterialPageRoute generateRoutes(RouteSettings settings) {
    // check  routes name matching when Navigator called
    if (settings.name != null) {
      var result = pages().where((element) => element.route == settings.name!);
      if (result.isNotEmpty) {
        // check application open for first time
        bool appFirstOpen =
            sharedPreferencesService.getBool(storageDeviceOpenFirstTime);
        if (result.first.route == AppRoutes.welcomePage && !appFirstOpen) {
          return MaterialPageRoute(
              builder: (_) => const LoginPage(), settings: settings);
        }
        return MaterialPageRoute(
            builder: (_) => result.first.page as Widget, settings: settings);
      }
    }
    print('invalid routes ${settings.name}');
    return MaterialPageRoute(builder: (_) => const WelcomePage());
  }
}

// unifying Bloc , pages and routes
class PageEntity {
  String? route;
  Widget? page;
  dynamic bloc;
  PageEntity({this.route, this.page, this.bloc});
}
