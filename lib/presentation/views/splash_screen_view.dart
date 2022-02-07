import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/app_profile_view_model.dart';
import 'package:volt/presentation/viewmodels/splash_screen_view_model.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    super.initState();
    var appProfileVM = context.read<AppProfileVM>();
    appProfileVM.fetchUserDataFromCache();
    appProfileVM.getUser();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      await context.read<SplashScreenVM>().handleNavigation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      resizeToAvoidBottomInset: false,
      builder: (_, size) {
        return Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            image: const DecorationImage(
              image: AssetImage('assets/images/blue_background.png'),
            ),
          ),
          child: Center(
            child: SizedBox(
              height: 200.h,
              width: 200.w,
              child: Image.asset('assets/images/volt_logo/volt_white.png'),
            ),
          ),
        );
      },
    );
  }
}
