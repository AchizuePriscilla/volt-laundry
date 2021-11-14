import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:volt/presentation/viewmodels/sign_up_view_model.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';

class AppProviders {
  //The providers for dependency injection and state management will be added here
  //as the app will use MultiProvider

  static final providers = <SingleChildWidget>[
    ChangeNotifierProvider(create: (_) => SplashScreenVM()),
    ChangeNotifierProvider(create: (_) => OnboardingVM()),
    ChangeNotifierProvider(create: (_) => SetPhoneNumberVM()),
    ChangeNotifierProvider(create: (_) => VerificationViewModel()),
    ChangeNotifierProvider(create: (_) => SignUpViewModel()),
  ];
}
