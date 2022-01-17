import 'package:volt/models/user_model.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/utils.dart';

class AppProfileVM extends BaseViewModel {
  late UserModel _user;

  String get email {
    try {
      return _user.email;
    } catch (e) {
      return '';
    }
  }

  int get vltNairaBalance {
    try {
      return _user.vltNairaBalance;
    } catch (e) {
      return 0;
    }
  }

   int get vltCoinBalance {
    try {
      return _user.vltCoinBalance;
    } catch (e) {
      return 0;
    }
  }

  ///Fetches user data from cache and parses it to a UserModel object
  Future<void> fetchUserData() async {
    try {
      var userData = await localCache.getUserData();
      _user = UserModel.fromJson(userData);
      notifyListeners();
    } catch (e) {
      AppLogger.logger.d(e);
    }
  }
}
