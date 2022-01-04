import 'package:dartz/dartz.dart';
import 'package:volt/models/api/api.dart';

class VerifyAccountResponse {
  final String code;
  final String message;
  final bool success;
  final ApiErrorResponse? error;
  const VerifyAccountResponse(
      {this.code = '', this.message = '', this.success = false, this.error});

factory VerifyAccountResponse.fromMap(Either<Failure, Success> json) {
    return json.fold(
      (failure) => VerifyAccountResponse(error: failure.error),
      (success) => VerifyAccountResponse(
        success: true,
        message: success.data['message'] ?? "",
        code: success.data['verificationCode'] ?? ''
      ),
    );
  }
}
