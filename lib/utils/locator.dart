import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:volt/data/local/local.dart';
import 'package:volt/data/remote/auth_apis/auth_repo.dart';
import 'package:volt/data/remote/auth_apis/auth_repo_impl.dart';
import 'package:volt/data/remote/auth_apis/auth_service.dart';
import 'package:volt/data/remote/auth_apis/auth_service_impl.dart';
import 'package:volt/data/remote/connectivity_service.dart';
import 'package:volt/data/remote/wallet_apis/wallet_repo.dart';
import 'package:volt/data/remote/wallet_apis/wallet_repo_impl.dart';
import 'package:volt/data/remote/wallet_apis/wallet_service.dart';
import 'package:volt/data/remote/wallet_apis/wallet_service_impl.dart';
import 'package:volt/handlers/handlers.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator({String baseApi = ''}) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerSingleton(sharedPreferences);

  //Local storage
  locator.registerLazySingleton<SecureStorage>(
    () => SecureStorageImpl(),
  );

  locator.registerLazySingleton<LocalCache>(
    () => LocalCacheImpl(
      sharedPreferences: locator(),
      storage: locator(),
    ),
  );

//Handlers
  locator
      .registerLazySingleton<NavigationHandler>(() => NavigationHandlerImpl());
  locator.registerLazySingleton<DialogHandler>(() => DialogHandlerImpl());
  locator.registerLazySingleton<BottomSheetHandler>(
      () => BottomSheetHandlerImpl());
//Services
  locator.registerLazySingleton<ConnectivityService>(
    () => ConnectivityServiceImpl(),
  );

  locator.registerLazySingleton<AuthService>(
    () => AuthServiceImpl(
      authRepo: locator(),
      cache: locator(),
    ),
  );

  locator.registerLazySingleton<WalletService>(
    () => WalletServiceImpl(
      walletRepo: locator(),
    ),
  );

//Repos

  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(baseApi),
  );
  locator.registerLazySingleton<WalletRepo>(
    () => WalletRepoImpl(baseApi),
  );
}
