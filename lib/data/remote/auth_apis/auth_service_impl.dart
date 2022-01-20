import 'dart:convert';
import 'dart:developer';
import 'package:volt/data/local/local.dart';
import 'package:volt/data/remote/auth_apis/auth_service.dart';
import 'package:volt/models/api/api.dart';
import 'package:volt/models/api/auth_requests.dart';
import 'package:volt/models/api/get_user_response.dart';
import 'package:volt/models/api/verification_response.dart';

import 'auth_repo.dart';

class AuthServiceImpl implements AuthService {
  final AuthRepository authRepo;
  final LocalCache cache;

  AuthServiceImpl({required this.authRepo, required this.cache});
  @override
  Future<VerifyAccountResponse> phoneVerification(
      PhoneVerificationRequest request) async {
    var res = await authRepo.requestPhoneVerificationCode(request);
    return res;
  }

  @override
  Future<LoginResponse> signUp(SignUpRequest request) async {
    var res = await authRepo.signUp(request);
    if (res.success) {
      await cache.saveToken(res.token!);
      log('token: ${res.token}');
      await cache.cacheUserData(
        value: json.encode(
          res.user!.toJson(),
        ),
      );
    }
    return res;
  }

  @override
  Future<LoginResponse> logIn(LoginRequest request) async {
    var res = await authRepo.logIn(request);

    if (res.success) {
      await cache.saveToken(res.token!);

      await cache.cacheUserData(
        value: json.encode(
          res.user!.toJson(),
        ),
      );
    }

    return res;
  }

  @override
  Future<GetUserResponse> getUser() async {
    var res = await authRepo.getUser();
    return res;
  }
}
