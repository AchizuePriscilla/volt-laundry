import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:volt/models/api/api.dart';
import 'package:volt/models/wallet_history_model.dart';

class GetWalletHistoryResponse extends Equatable{
  final bool success;
  final WalletHistoryModel? user;
  final ApiErrorResponse? error;

  const GetWalletHistoryResponse({
    this.success = false,
    this.error,
    this.user,
  });

  factory GetWalletHistoryResponse.fromMap(Either<Failure, Success> json) {
    return json.fold(
      (failure) => GetWalletHistoryResponse(error: failure.error),
      (success) => GetWalletHistoryResponse(
        success: true,
        user: WalletHistoryModel.fromMap(success.data['history'] ?? ""),
      ),
    );
  }

  @override
  List<Object?> get props => [
        success,
        error,
      ];
}