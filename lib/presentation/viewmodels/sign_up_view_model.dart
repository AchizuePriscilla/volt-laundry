import 'dart:developer';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:volt/models/api/auth_requests.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/utils.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:volt/utils/string_utils.dart';

class SignUpViewModel extends BaseViewModel {
  late String name;
  late String email;
  late String password;
  late String phoneNumber;
  late String address;
  late String country;
  late String state;
  late double latitude;
  late double longitude;
  late String timeOfUserCreation;
  late String timeOfUserUpdate;
  late String verificationCode;
  late Position currentPosition;
  late String downloadUrl;
  File? _pickedImage;
  FirebaseStorage storage = FirebaseStorage.instance;
  var setImage = '';

  void setCurrentLocation() async {
    await Geolocator.requestPermission();
    currentPosition = await geolocatorService.getCurrentPosition();
    latitude = currentPosition.latitude;
    longitude = currentPosition.longitude;
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    Placemark placemark = placemarks[0];
    country = placemark.country!;
    state = placemark.administrativeArea!;
    notifyListeners();
  }

  void navigateToRoute(String route) {
    navigationHandler.pushNamed(route);
  }

  ///validates password text field
  String? validatePassword(String password) =>
      Validators.validatePassword(password);

  ///Validates email text field
  String? validateEmail(String email) => Validators.validateEmail(email);

  ///Validates full name text field
  String? validateFullName(String name) => Validators.validateFullName(name);

  ///Validates phone number text field
  String? validatePhoneNumber(String phoneNumber) =>
      Validators.validatePhoneNumber(phoneNumber);

  String? validateText(String text) =>
      Validators.validateTextInput(text, 'Enter a valid address');
  updateFields({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    required String address,
  }) {
    this.name = name;
    this.email = email;
    this.password = password;
    this.phoneNumber = phoneNumber;
    this.address = address;
    timeOfUserCreation = DateTime.now().toString();
    timeOfUserUpdate = DateTime.now().toString();
    log(this.name);
  }

  ///Caches VerificationViewRoute with last email so
  //app can resume from that exact same screen if it's closed before account is verified
  void cachePage(String phoneNumber) {
    localCache.saveToLocalCache(
      key: lastPage,
      value: verificationViewRoute,
    );
    localCache.saveToLocalCache(key: lastPhoneNumber, value: phoneNumber);
  }

  Future<void> sendVerificationToken() async {
    try {
      if (loading) return;
      toggleLoading(true);
      var formattedNumber = phoneNumber.substring(1);
      var finalNumber = '234' + formattedNumber;
      var res = await authService.phoneVerification(
          PhoneVerificationRequest(phoneNumber: finalNumber));

      if (res.success) {
        verificationCode = res.code;
        log('Verification code sent successfully');
        log(res.code);
        toggleLoading(false);
        navigateToRoute(verificationViewRoute);
        cachePage(phoneNumber);
        // await localCache.removeFromLocalCache(lastPage);
        // await localCache.removeFromLocalCache(lastEmail);
      } else {
        log('Verification code sending unsuccessful');
        toggleLoading(false);
      }
    } catch (e) {
      AppLogger.logger.d(e);
      toggleLoading(false);
    }
  }

  Future<void> verifyCode(String code) async {
    try {
      if (loading) return;
      toggleLoading(true);
      if (code == verificationCode) {
        await localCache.removeFromLocalCache(lastPhoneNumber);
        navigationHandler.pushReplacementNamed(
          setProfilePictureViewRoute,
        );
        await localCache.saveToLocalCache(
            key: lastPage, value: setProfilePictureViewRoute);
      } else {
        dialogHandler.showDialog(
            contentType: DialogContentType.error,
            message: "Please enter correct code");
      }
      log(name);
      toggleLoading(false);
    } catch (e) {
      AppLogger.logger.d(e);
      toggleLoading(false);
    }
  }

  ///Picks images from user's gallery
  Future<void> pickImage({bool isCamera = false}) async {
    try {
      if (isProfilePhotoUploading) return;
      togglePhotoUploading(true);
      _pickedImage = await imagePickerService.pickImage(camera: isCamera);
      String imageName = path.basename(_pickedImage!.path);

      File imageFile = File(_pickedImage!.path);

      await storage.ref(imageName).putFile(imageFile);
      downloadUrl = await storage.ref(imageName).getDownloadURL();
      Future<String> downloadedImage;
      downloadedImage = fileDownloadService.downloadFile(
          url: downloadUrl,
          savePath:
              "volt" + imageName + ".${StringUtils.getExtension(downloadUrl)}");
      setImage = await downloadedImage;
      log(setImage);
      notifyListeners();
      togglePhotoUploading(false);
    } catch (e) {
      AppLogger.logger.d(e);
      togglePhotoUploading(false);
    }
  }

  ///Makes a network request to create an account with `email` and `password`
  Future<void> signUp() async {
    try {
      if (loading) return;

      toggleLoading(true);
      await Geolocator.requestPermission();
      currentPosition = await geolocatorService.getCurrentPosition();
      latitude = currentPosition.latitude;
      longitude = currentPosition.longitude;
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark placemark = placemarks[0];
      country = placemark.country!;
      state = placemark.administrativeArea!;

      var res = await authService.signUp(
        SignUpRequest(
            name: name,
            phoneNumber: phoneNumber,
            email: email,
            password: password,
            address: address,
            country: country,
            state: state,
            avatar: downloadUrl,
            latitude: latitude,
            longitude: longitude,
            timeOfUserCreation: timeOfUserCreation,
            timeOfUserUpdate: timeOfUserUpdate),
      );
      if (res.success) {
        //remove cached data and navigate to HomeViewRoute
        await localCache.removeFromLocalCache(lastPage);
        navigationHandler.pushReplacementNamed(
          homeViewRoute,
        );
      } else {
        //if user is already registered, navigate to LoginView
        if (res.error!.type == ErrorType.emailExists) {
          dialogHandler.showDialog(
            message: res.error!.message + "\nLogin to continue",
          );
          navigationHandler.pushReplacementNamed(logInViewRoute);
        } else {
          //show error message
          dialogHandler.showDialog(message: res.error!.message);
        }
      }
      toggleLoading(false);
    } catch (e) {
      AppLogger.logger.d(e);
      toggleLoading(false);
    }
  }
}
