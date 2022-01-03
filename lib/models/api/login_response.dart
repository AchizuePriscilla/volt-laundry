import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:volt/models/api/api.dart';
import 'package:volt/models/user_model.dart';
class LoginResponse extends Equatable {
  final String? token;
  final bool success;
  final UserModel? user;
  final ApiErrorResponse? error;

 const LoginResponse({
    this.token,
    this.success = false,
    this.error,
    this.user,
  });

  factory LoginResponse.fromMap(Either<Failure, Success> json) {
    return json.fold(
      (failure) => LoginResponse(error: failure.error),
      (success) => LoginResponse(
        success: true,
        token: success.data['data']["access_token"] ?? "",
        user: UserModel.fromJson(success.data['data']['user']),
      ),
    );
  }

  @override
  List<Object?> get props => [
        token,
        success,
        error,
      ];
}
