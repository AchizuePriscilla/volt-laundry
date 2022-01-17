import 'package:dartz/dartz.dart';
import 'package:volt/models/api/api.dart';

class ProcessOrderResponse {
  final String orderId;
  final String orderNo;
  final String message;
  final bool success;
  final ApiErrorResponse? error;

  const ProcessOrderResponse(
      {this.orderId = '',
      this.orderNo = '',
      this.message = '',
      this.success = false,
      this.error});

  factory ProcessOrderResponse.fromMap(Either<Failure, Success> json) {
    return json.fold((failure) => ProcessOrderResponse(error: failure.error),
        (success) => ProcessOrderResponse(
          success: true,
          message: success.data['message'] ?? '',
          orderId: success.data['orderId'] ?? '',
          orderNo: success.data['orderNo']
        ));
  }
}
