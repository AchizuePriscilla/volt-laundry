import 'package:country_code_picker/country_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:volt/handlers/handlers.dart';
import 'package:volt/presentation/theme/light_theme.dart';
import 'package:volt/utils/constants.dart';
import 'package:volt/utils/providers.dart';
import 'package:volt/utils/route_generator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'presentation/shared/dialog_manager.dart';
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
                supportedLocales: countries,
                localizationsDelegates: const [
                  CountryLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                theme: lightTheme,
                debugShowCheckedModeBanner: false,
                navigatorKey: locator<NavigationHandler>().navigatorKey,
                onGenerateRoute: RouteGenerator.onGenerateRoute,
                initialRoute: buyCoinViewRoute,
                builder: (context, widget) => Navigator(
                  onGenerateRoute: (settings) => CupertinoPageRoute(
                    builder: (context) => DialogManager(
                      child: widget!,
                    ),
                  ),
                ),
              );
            }));
  }
}
