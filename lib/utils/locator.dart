import 'package:get_it/get_it.dart';
import 'package:volt/handlers/handlers.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator({String baseApi = ''})async{
  locator
      .registerLazySingleton<NavigationHandler>(() => NavigationHandlerImpl());
}