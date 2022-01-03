import 'package:volt/data/local/local.dart';
import 'package:volt/data/remote/auth_apis/auth_service.dart';
import 'package:volt/models/api/auth_requests.dart';
import 'package:volt/models/api/general_response.dart';

import 'auth_repo.dart';

class AuthServiceImpl implements AuthService {
  final AuthRepository authRepo;
  final LocalCache cache;

  AuthServiceImpl({required this.authRepo, required this.cache});
  @override
  Future<GeneralResponse> phoneVerification(
      PhoneVerificationRequest request) async {
    var res = await authRepo.requestPhoneVerificationCode(request);
    return res;
  }
}