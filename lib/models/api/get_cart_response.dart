import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:volt/models/api/api.dart';
import 'package:volt/models/process_order_model.dart';

class GetCartResponse extends Equatable {
  final bool success;
  final CartModel? cartModel;
  final ApiErrorResponse? error;

  const GetCartResponse({
    this.success = false,
    this.error,
    this.cartModel,
  });

  factory GetCartResponse.fromMap(Either<Failure, Success> json) {
    return json.fold(
      (failure) => GetCartResponse(error: failure.error),
      (success) => GetCartResponse(
        success: true,
        cartModel: CartModel.fromMap(success.data),
      ),
    );
  }

  @override
  List<Object?> get props => [success, error, cartModel];
}
