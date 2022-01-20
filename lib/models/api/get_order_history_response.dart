import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:volt/models/api/api.dart';
import 'package:volt/models/order_history_model.dart';

class GetOrderHistoryResponse extends Equatable {
    final bool success;
  final OrderHistoryModel? orderHistory;
  final ApiErrorResponse? error;

  const GetOrderHistoryResponse({
    this.success = false,
    this.error,
    this.orderHistory,
  });

  factory GetOrderHistoryResponse.fromMap(Either<Failure, Success> json) {
  
    return json.fold(
      (failure) => GetOrderHistoryResponse(error: failure.error),
      (success) => GetOrderHistoryResponse(
        success: true,
        orderHistory: OrderHistoryModel.fromMap(success.data),
      ),
    );
  }

  @override
  List<Object?> get props => [
        success,
        error,
      ];
}