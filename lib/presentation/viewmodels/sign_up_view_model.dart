import 'dart:developer';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:volt/models/api/auth_requests.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/utils.dart';

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

  void setCurrentLocation() async {
    Geolocator.requestPermission();
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
      var res = await authService.phoneVerification(
          PhoneVerificationRequest(phoneNumber: phoneNumber));

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

  ///Makes a network request to create an account with `email` and `password`
  Future<void> signUp(String code) async {
    try {
      if (loading) return;

      toggleLoading(true);
      if (code == verificationCode) {
        var res = await authService.signUp(
          SignUpRequest(
              name: name,
              phoneNumber: phoneNumber,
              email: email,
              password: password,
              address: address,
              country: country,
              state: state,
              latitude: latitude,
              longitude: longitude,
              timeOfUserCreation: timeOfUserCreation,
              timeOfUserUpdate: timeOfUserUpdate),
        );
        if (res.success) {
          //remove cached data and navigate to HomeViewRoute
          await localCache.removeFromLocalCache(lastPage);
          await localCache.removeFromLocalCache(lastPhoneNumber);
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
      } else {
        log("Codes don't match");
        toggleLoading(false);
      }
    } catch (e) {
      AppLogger.logger.d(e);
      toggleLoading(false);
    }
  }
}
