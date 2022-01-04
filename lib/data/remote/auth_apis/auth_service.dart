import 'package:volt/models/api/api.dart';
import 'package:volt/models/api/auth_requests.dart';
import 'package:volt/models/api/verification_response.dart';

abstract class AuthService {
  Future<VerifyAccountResponse> phoneVerification(
      PhoneVerificationRequest request);
  Future<LoginResponse> signUp(SignUpRequest request);
  Future<LoginResponse> logIn(LoginRequest request);
}
