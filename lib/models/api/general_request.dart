import 'package:equatable/equatable.dart';

class GeneralRequest extends Equatable {
  final String accessToken;

  const GeneralRequest({required this.accessToken});


   Map<String, dynamic> toMap() {
    return {'X-ACCESS-TOKEN': accessToken};
  }

  @override
  List<Object?> get props => [accessToken];
}
