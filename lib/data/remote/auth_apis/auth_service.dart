import 'package:volt/models/api/api.dart';
import 'package:volt/models/api/auth_requests.dart';
import 'package:volt/models/api/general_request.dart';
import 'package:volt/models/api/get_user_response.dart';
import 'package:volt/models/api/verification_response.dart';

abstract class AuthService {
  Future<VerifyAccountResponse> phoneVerification(
      PhoneVerificationRequest request);
  Future<LoginResponse> signUp(SignUpRequest request);
  Future<LoginResponse> logIn(LoginRequest request);
  Future<GetUserResponse> getUser();
}
