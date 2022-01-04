import 'package:equatable/equatable.dart';

class PhoneVerificationRequest extends Equatable {
  final String phoneNumber;

  const PhoneVerificationRequest({required this.phoneNumber});

  Map<String, dynamic> toMap() {
    return {'phone': phoneNumber};
  }

  @override
  List<Object?> get props => [phoneNumber];
}

class SignUpRequest extends Equatable {
  final String name;
  final String phoneNumber;
  final String email;
  final String password;
  final String address;
  final String country;
  final String state;
  final double latitude;
  final double longitude;
  final String timeOfUserCreation;
  final String timeOfUserUpdate;

  const SignUpRequest(
      {required this.name,
      required this.phoneNumber,
      required this.email,
      required this.password,
      required this.address,
      required this.country,
      required this.state,
      required this.latitude,
      required this.longitude,
      required this.timeOfUserCreation,
      required this.timeOfUserUpdate});

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "password": password,
      "name": name,
      "phone": phoneNumber,
      "location": {
        "address": address,
        "country": country,
        "state": state,
        "lat": latitude,
        "lng": longitude
      }
    };
  }

  @override
  List<Object?> get props => [
        name,
        email,
        state,
        address,
        country,
        password,
        latitude,
        longitude,
        phoneNumber,
        timeOfUserUpdate,
        timeOfUserCreation,
      ];
}

class LoginRequest extends Equatable {
  final String email;
  final String password;

  const LoginRequest({required this.email, required this.password});
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  @override
  List<Object?> get props => [email, password];
}
