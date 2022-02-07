import 'dart:developer';

import 'package:volt/utils/utils.dart';

import 'base_view_model.dart';

class SplashScreenVM extends BaseViewModel {
  // /Checks if there is any cached page and navigates to it
  bool _checkLastPage() {
    bool isCached = false;
    String? lastpage = localCache.getFromLocalCache(lastPage) as String?;

    if (lastpage == verificationViewRoute) {
      isCached = true;
      navigationHandler.pushReplacementNamed(
        verificationViewRoute,
      );
    }
    if (lastpage == setProfilePictureViewRoute) {
      isCached = true;
      navigationHandler.pushReplacementNamed(setProfilePictureViewRoute);
    }
    return isCached;
  }

  // Future<void> handleNavigation() async {
  //   await Future.delayed(const Duration(seconds: 2)).then((value) async {
  //     navigationHandler.pushNamed(onboardingViewRoute);
  //   });
  // }

  ///Handles navigation from SplashScreenView on app start
  Future<void> handleNavigation() async {
    await Future.delayed(const Duration(seconds: 2)).then((value) async {
      await localCache.getToken().then(
        (token) async {
          log('getting token from cache: $token');
          //check if user is logged in
          if (token != null && token.isNotEmpty) {
            //if user is logged in,
            navigationHandler.pushReplacementNamed(homeViewRoute);
          } else {
            //#beginning of user not logged in flow
            //if user is not logged in, check if user has been onboarded
            bool hasBeenOnboarded =
                localCache.getFromLocalCache(onboardingDone) != null;

            if (hasBeenOnboarded) {
              //if user has been onboarded, check if there is any cached page
              //and navigate to it, if any
              if (_checkLastPage()) {
                return;
              }

              //no cached page but user has been onboarded?
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
}
