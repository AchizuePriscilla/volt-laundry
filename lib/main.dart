import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:volt/handlers/handlers.dart';
import 'package:volt/presentation/views/splash_screen_view.dart';
import 'package:volt/utils/providers.dart';
import 'package:volt/utils/route_generator.dart';

import 'utils/locator.dart';

void main() async {
  await setupLocator();
  runApp(const VoltApp());
}

class VoltApp extends StatelessWidget {
  const VoltApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 630),
        builder: () => MultiProvider(
            providers: AppProviders.providers,
            builder: (context, child) {
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  navigatorKey: locator<NavigationHandler>().navigatorKey,
                  onGenerateRoute: RouteGenerator.onGenerateRoute,
                  home: const SplashScreenView());
            }));
  }
}
