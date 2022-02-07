import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:volt/models/api/auth_requests.dart';
import 'package:volt/models/user_model.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/string_utils.dart';
import 'package:volt/utils/utils.dart';
import 'package:path/path.dart' as path;

class AppProfileVM extends BaseViewModel {
  late UserModel _user;
  late UserModel _rxUser;
  late String downloadUrl;
  File? _pickedImage;
  FirebaseStorage storage = FirebaseStorage.instance;

  String? get email {
    try {
      return _user.email!;
    } catch (e) {
      return '';
    }
  }

  String get password {
    try {
      return _user.password!;
    } catch (e) {
      return '';
    }
  }

  String? get id {
    try {
      return _user.id!;
    } catch (e) {
      return '';
    }
  }

  String? get timeOfCreation {
    try {
      return _user.timeOfCreation!;
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

  int? get latitude {
    try {
      return _user.latitude;
    } catch (e) {
      return 0;
    }
  }

  int? get longitude {
    try {
      return _user.longitude;
    } catch (e) {
      return 0;
    }
  }

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

  ///Picks images from user's gallery
  Future<void> pickImage({bool isCamera = false}) async {
    try {
      if (loading) return;
      toggleLoading(true);
      _pickedImage = await imagePickerService.pickImage(camera: isCamera);
      String imageName = path.basename(_pickedImage!.path);

      File imageFile = File(_pickedImage!.path);

      await storage.ref(imageName).putFile(imageFile);
      downloadUrl = await storage.ref(imageName).getDownloadURL();

      await fileDownloadService.downloadFile(
          url: downloadUrl,
          savePath:
              "volt" + imageName + ".${StringUtils.getExtension(downloadUrl)}");

      log(name);
      notifyListeners();
      toggleLoading(false);
    } catch (e) {
      AppLogger.logger.d(e);
      toggleLoading(false);
    }
  }

  Future<void> editUser(
      {required String name,
      required String phoneNumber,
      required String address,
      required double latitude,
      required double longitude}) async {
    try {
      if (loading) return;
      toggleLoading(true);
      var res = await authService.editUser(SignUpRequest(
          name: name,
          phoneNumber: phoneNumber,
          email: email!,
          password: password,
          address: address,
          country: _user.country!,
          state: _user.state!,
          latitude: latitude,
          longitude: longitude,
          timeOfUserCreation: timeOfCreation!,
          timeOfUserUpdate: DateTime.now().toString(),
          avatar: downloadUrl.isEmpty
              ? _user.avatar != "undefined"
                  ? _user.avatar!
                  : "undefined"
              : downloadUrl));
    } catch (e) {}
  }

  void navigateToEditProfileView() {
    navigationHandler.pushNamed(editProfileViewRoute);
  }
}
