import 'package:volt/data/config/base_api.dart';
import 'package:volt/data/remote/auth_apis/auth_repo.dart';
import 'package:volt/models/api/auth_requests.dart';
import 'package:volt/models/api/general_response.dart';

class AuthRepositoryImpl extends BaseApi implements AuthRepository {
  AuthRepositoryImpl(String baseApi) : super(baseApi);
  static const String phoneAuth = 'auth/phone-auth';
  @override
  Future<GeneralResponse> requestPhoneVerificationCode(PhoneVerificationRequest request) async{
    var response = await post(
      phoneAuth,
      data: request.toMap(),
    );

    return GeneralResponse.fromMap(response);
  }
}
