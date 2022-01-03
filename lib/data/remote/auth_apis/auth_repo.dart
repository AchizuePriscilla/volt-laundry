import 'package:volt/models/api/api.dart';
import 'package:volt/models/api/auth_requests.dart';
import 'package:volt/models/api/general_response.dart';

abstract class AuthRepository {
  Future<GeneralResponse> requestPhoneVerificationCode(
      PhoneVerificationRequest request);
  Future<LoginResponse> signUp(SignUpRequest request);
}
