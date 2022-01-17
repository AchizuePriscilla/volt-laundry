import 'package:equatable/equatable.dart';

class GetUserRequest extends Equatable {
  final String accessToken;

  const GetUserRequest({required this.accessToken});


   Map<String, dynamic> toMap() {
    return {'X-ACCESS-TOKEN': accessToken};
  }

  @override
  List<Object?> get props => [accessToken];
}
