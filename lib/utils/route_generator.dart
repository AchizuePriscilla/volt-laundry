import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volt/presentation/views/views.dart';
import 'package:volt/utils/utils.dart';

class RouteGenerator {
  ///Generates routes, extracts and passes navigation arguments.
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreenViewRoute:
        return _getPageRoute(const SplashScreenView());
      case onboardingViewRoute:
        return _getPageRoute(const OnboardingView());
      default:
        return _getPageRoute(_errorPage);
    }
  }

  //Wraps widget with a CupertinoPageRoute and adds route settings
  static CupertinoPageRoute _getPageRoute(
    Widget child, [
    String? routeName,
    dynamic args,
  ]) =>
      CupertinoPageRoute(
        builder: (context) => child,
        settings: RouteSettings(
          name: routeName,
          arguments: args,
        ),
      );

  ///Error page shown when app attempts navigating to an unknown route
  static final Widget _errorPage = Scaffold(
    appBar: AppBar(
        title: const Text(
      'Page not found',
      style: TextStyle(color: Colors.red),
    )),
    body: const Center(
      child: Text(
        'Error! Page not found',
        style: TextStyle(color: Colors.red),
      ),
    ),
  );
}
