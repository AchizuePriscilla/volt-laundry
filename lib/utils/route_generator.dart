import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volt/models/navigation/laundry_details_args.dart';
import 'package:volt/models/navigation/oops_args.dart';
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
      case setPhoneNumberViewRoute:
        return _getPageRoute(const SetPhoneNumberView());
      case verificationViewRoute:
        return _getPageRoute(const VerificationView());
      case signUpViewRoute:
        return _getPageRoute(const SignUpView());
      case logInViewRoute:
        return _getPageRoute(const LogInView());
      case homeViewRoute:
        return _getPageRoute(const HomeView());
      case laundryViewRoute:
        return _getPageRoute(const LaundryView());
      case cartView:
        return _getPageRoute(const CartView());
      case laundryDetailsRoute:
        final clothType = settings.arguments;
        if (clothType != null && clothType is LaundryDetailsArgs) {
          return _getPageRoute(LaundryDetails(clothType: clothType.clothType));
        }
        return _getPageRoute(
            _errorPage(message: "ClothType parameter not passed"));
      case addClothViewRoute:
        final clothType = settings.arguments;
        if (clothType != null && clothType is LaundryDetailsArgs) {
          return _getPageRoute(AddClothView(clothType: clothType.clothType));
        }
        return _getPageRoute(
            _errorPage(message: "ClothType parameter not passed"));

      case oopsViewRoute:
        final message = settings.arguments;
        if (message != null && message is OopsArgs) {
          return _getPageRoute(Oops(message: message.message));
        }

        return _getPageRoute(
            _errorPage(message: "Message parameter not passed"));
      default:
        return _getPageRoute(_errorPage());
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
  static Widget _errorPage({String message = "Error! Page not found"}) =>
      Scaffold(
        appBar: AppBar(
            title: const Text(
          'Page not found',
          style: TextStyle(color: Colors.red),
        )),
        body: Center(
          child: Text(
            message,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
}
