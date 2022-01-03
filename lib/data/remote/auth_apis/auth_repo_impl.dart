import 'package:volt/data/config/base_api.dart';
import 'package:volt/data/remote/auth_apis/auth_repo.dart';
import 'package:volt/models/api/auth_requests.dart';
import 'package:volt/models/api/general_response.dart';
import 'package:volt/models/api/login_response.dart';

class AuthRepositoryImpl extends BaseApi implements AuthRepository {
  AuthRepositoryImpl(String baseApi) : super(baseApi);
  static const String phoneAuth = 'auth/phone-auth';
  static const String registerUser = 'user/register';
  @override
  Future<GeneralResponse> requestPhoneVerificationCode(
      PhoneVerificationRequest request) async {
    var response = await post(
      phoneAuth,
      data: request.toMap(),
    );

    return GeneralResponse.fromMap(response);
  }

  @override
  Future<LoginResponse> signUp(SignUpRequest request) async {
    var response = await post(phoneAuth, data: request.toMap());
    return LoginResponse.fromMap(response);
  }
}
