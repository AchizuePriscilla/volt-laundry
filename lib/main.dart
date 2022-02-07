import 'package:country_code_picker/country_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'firebase_options.dart';
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
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await loadEnvFile();
  final url = dot_env.dotenv.env['STAGING_API']!;

  await setupLocator(baseApi: url);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then(
    (value) async {
      await SentryFlutter.init(
        (options) {
          options.dsn =
              'https://ed4d40b9b74e42ef95b468b13caa4689@o1007712.ingest.sentry.io/5970772';
        },
        appRunner: () => runApp(const VoltApp()),
      );
    },
  );
}

class VoltApp extends StatelessWidget {
  const VoltApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
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
              initialRoute: splashScreenViewRoute,
              builder: (context, widget) => ScreenUtilInit(
                    designSize: const Size(360, 630),
                    builder: () => Navigator(
                      onGenerateRoute: (settings) => CupertinoPageRoute(
                        builder: (context) => DialogManager(
                          child: widget!,
                        ),
                      ),
                    ),
                  ));
        });
  }
}
