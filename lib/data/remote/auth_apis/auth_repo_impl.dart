import 'package:volt/data/config/base_api.dart';
import 'package:volt/data/remote/auth_apis/auth_repo.dart';
import 'package:volt/models/api/auth_requests.dart';
import 'package:volt/models/api/get_user_response.dart';
import 'package:volt/models/api/login_response.dart';
import 'package:volt/models/api/verification_response.dart';

class AuthRepositoryImpl extends BaseApi implements AuthRepository {
  AuthRepositoryImpl(String baseApi) : super(baseApi);
  static const String phoneAuth = 'auth/phone-auth';
  static const String registerUser = 'user/register';
  static const String login = 'user/login';
  static const String user = 'user';
  @override
  Future<VerifyAccountResponse> requestPhoneVerificationCode(
      PhoneVerificationRequest request) async {
    var response = await post(
      phoneAuth,
      data: request.toMap(),
    );

    return VerifyAccountResponse.fromMap(response);
  }

  @override
  Future<LoginResponse> signUp(SignUpRequest request) async {
    var response = await post(registerUser, data: request.toMap());
    return LoginResponse.fromMap(response);
  }

  @override
  Future<LoginResponse> logIn(LoginRequest request) async {
    var response = await post(
      login,
      data: request.toMap(),
    );

    return LoginResponse.fromMap(response);
  }

  @override
  Future<GetUserResponse> getUser() async {
    var response = await get(user);
    return GetUserResponse.fromMap(response);
  }

  @override
  Future<GetUserResponse> editUser(SignUpRequest request) async {
    var res = await patch(user, data: request.toMap());
    return GetUserResponse.fromMap(res);
  }
}
