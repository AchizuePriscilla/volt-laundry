import 'package:volt/models/api/api.dart';
import 'package:volt/models/api/auth_requests.dart';

abstract class AuthService {
  Future<GeneralResponse> phoneVerification(PhoneVerificationRequest request);
  Future<LoginResponse> signUp(SignUpRequest request);
}
