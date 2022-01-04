import 'dart:async';
import 'dart:developer';
import 'package:country_code_picker/country_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:volt/handlers/handlers.dart';
import 'package:volt/presentation/theme/light_theme.dart';
import 'package:volt/utils/utils.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'presentation/shared/dialog_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadEnvFile();
  final url = dot_env.dotenv.env['STAGING_API']!;
  await setupLocator(baseApi: url);
  runZonedGuarded(
    () => runApp(const VoltApp()),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
  // runApp(const VoltApp());
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
              initialRoute: logInViewRoute,
              builder: (context, widget) => Navigator(
                onGenerateRoute: (settings) => CupertinoPageRoute(
                  builder: (context) => DialogManager(
                    child: widget!,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
