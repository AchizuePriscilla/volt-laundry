import 'package:dartz/dartz.dart';
import 'package:volt/models/api/api.dart';

class TransactionInitResponse {
  final String message;
  final bool success;
  final ApiErrorResponse? error;
  final bool status;
  final String authorizationUrl;
  final String accessCode;
  final String reference;

  const TransactionInitResponse(
      {this.message = '',
      this.success = false,
      this.error,
      this.status = false,
      this.authorizationUrl = '',
      this.accessCode = '',
      this.reference = ''});
  factory TransactionInitResponse.fromMap(Either<Failure, Success> json) {
    return json.fold(
      (failure) => TransactionInitResponse(error: failure.error),
      (success) => TransactionInitResponse(
        success: true,
        message: success.data['data']['message'] ?? "",
        status: success.data['data']['status'] ?? false,
        accessCode: success.data['data']['data']['access_code'] ?? '',
        authorizationUrl:
            success.data['data']['data']['authorization_url'] ?? '',
        reference: success.data['data']['data']['reference'] ?? '',
      ),
    );
  }
}
