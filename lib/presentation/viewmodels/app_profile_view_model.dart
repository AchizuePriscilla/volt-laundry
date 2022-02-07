import 'dart:developer';
import 'package:volt/models/user_model.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/utils.dart';

class AppProfileVM extends BaseViewModel {
  late UserModel _user;
  late UserModel _rxUser;

  String? get email {
    try {
      return _user.email!;
    } catch (e) {
      return '';
    }
  }

  String get name {
    try {
      return _user.name!;
    } catch (e) {
      return '';
    }
  }

  String get address {
    try {
      return _user.address!;
    } catch (e) {
      return '';
    }
  }

  String get number {
    try {
      return _user.phoneNumber!;
    } catch (e) {
      return '';
    }
  }

  String get profilePic {
    try {
      return _rxUser.avatar!;
    } catch (e) {
      return '';
    }
  }

  // double get latitude {
  //   try {
  //     return _user.latitude;
  //   } catch (e) {
  //     return 0;
  //   }
  // }

  // double get longitude {
  //   try {
  //     return _user.longitude;
  //   } catch (e) {
  //     return 0;
  //   }
  // }

  int get vltNairaBalance {
    try {
      log('Naira balance : ${_rxUser.vltNairaBalance}');
      return _rxUser.vltNairaBalance!;
    } catch (e) {
      return 0;
    }
  }

  int get vltCoinBalance {
    try {
      return _rxUser.vltCoinBalance!;
    } catch (e) {
      return 0;
    }
  }

  Future<void> getUser() async {
    try {
      var user = await authService.getUser();
      _rxUser = user.user!;
    } catch (e) {
      AppLogger.logger.d(e);
    }
  }

  ///Fetches user data from cache and parses it to a UserModel object
  Future<void> fetchUserDataFromCache() async {
    try {
      var userData = await localCache.getUserData();
      _user = UserModel.fromJson(userData);
      notifyListeners();
    } catch (e) {
      AppLogger.logger.d(e);
    }
  }

  void navigateToEditProfileView() {
    navigationHandler.pushNamed(editProfileViewRoute);
  }
}
