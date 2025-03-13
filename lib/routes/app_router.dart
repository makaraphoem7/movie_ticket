import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/app_constants.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/screens/account/profile_screen.dart';
import 'package:flutter_application_1/screens/auth/login_screen.dart';
import 'package:flutter_application_1/screens/auth/sign_up_screen.dart';
import 'package:flutter_application_1/screens/boarding/open_app.dart';
import 'package:flutter_application_1/screens/home/home_screen.dart';
import 'package:flutter_application_1/screens/detail/movie_detail_screen.dart';
import 'package:flutter_application_1/screens/search/search_screen.dart';
import '../data/models/movie.dart';

import 'app_routes.dart';

@immutable
class AppRouter {
  const AppRouter._();

  /// The global key used to access navigator without context
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static const String initialRoute = Routes.init;

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    // String? queryPath = "";
    String? route = settings.name;

    switch (route) {
      case Routes.init:
        return _routeBuilder(const MyApp(), Routes.init);
      case Routes.splash:
        // -- if any argument for this route -- //
        // var argument = args == null ? null : args as Map;
        return _routeBuilder(const SplashScreen(), Routes.welcome);
      case Routes.login:
        return _routeBuilder(
          const LoginScreen(),
          Routes.login,
        );
      case Routes.signup:
        return _routeBuilder(
          const SignUpScreen(),
          Routes.signup,
        );
      case Routes.homescreen:
        return _routeBuilder(
          const HomeScreen(),
          Routes.homescreen,
        );
      case Routes.searchscreen:
        return _routeBuilder(
          SearchScreen(),
          Routes.searchscreen,
        );
      case Routes.profilescreen:
        return _routeBuilder(
          ProfileScreen(),
          Routes.profilescreen,
        );
      case Routes.detailscreen:
       if (args is Movie) {
        return _routeBuilder(
          MovieDetailScreen(movie: args),
          Routes.detailscreen,
        );
  }

      default:
        return _errorRoute();
    }
  }

  static _routeBuilder(Widget page, String routeName, {Object? args}) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => page,
      settings: RouteSettings(name: routeName, arguments: args),
      fullscreenDialog: false
    );
  }

  /// This method returns an error page to indicate redirection to an
  /// unknown route.
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Unknown Route'),
          leading: BackButton(color: AppConstants.backgroundColor),
        ),
        body: const Center(
          child: Text('Unknown Route'),
        ),
      ),
    );
  }

  /// This method is used to navigate to a screen using it's name
  static Future<dynamic> pushNamed(String routeName, {dynamic args}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: args);
  }

  /// This method is used to navigate back to the previous screen.
  ///
  /// The [result] can contain any value that we want to return to the previous
  /// screen.
  static Future<void> pop([dynamic result]) async {
    navigatorKey.currentState?.pop(result);
  }

  /// This method is used to navigate all the way back to a specific screen.
  ///
  /// The [routeName] is the name of the screen we want to go back to.
  static void popUntil(String routeName) {
    navigatorKey.currentState?.popUntil(ModalRoute.withName(routeName));
  }

  /// This method is used to navigate all the way back to the first screen
  /// shown on startup i.e. the [initialRoute].
  static void popUntilRoot() {
    navigatorKey.currentState?.popUntil(ModalRoute.withName(initialRoute));
  }

  static void pushReplacementNamed(String routeName) {
    navigatorKey.currentState?.pushReplacementNamed(routeName);
  }

  static void pushNamedAndRemoveUntil(String routeName, {dynamic args}) {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false, arguments: args);
  }
}
