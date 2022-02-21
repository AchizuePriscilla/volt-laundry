import 'package:volt/utils/utils.dart';
import 'base_view_model.dart';

class SplashScreenVM extends BaseViewModel {
  ///Handles navigation from SplashScreenView on app start
  Future<void> handleNavigation() async {
    await Future.delayed(const Duration(seconds: 2)).then((value) async {
      await localCache.getToken().then(
        (token) async {
          //check if user is logged in
          if (token != null && token.isNotEmpty) {
            //if user is logged in,
            getUser();
            navigationHandler.pushReplacementNamed(homeViewRoute);
          } else {
            //#beginning of user not logged in flow
            //if user is not logged in, check if user has been onboarded
            bool hasBeenOnboarded =
                localCache.getFromLocalCache(onboardingDone) != null;

            if (hasBeenOnboarded) {
              //User has been onboarded?
              //navigate to LoginView

              navigationHandler.pushReplacementNamed(logInViewRoute);
            } else {
              //if user has not been onboarded, navigate to OnboardingView
              navigationHandler.pushReplacementNamed(onboardingViewRoute);
            }
            //#end of user not logged in flow
          }
        },
      );
    });
  }

  Future<void> getUser() async {
    try {
      await authService.getUser();
    } catch (e) {
      AppLogger.logger.d(e);
    }
  }
}
