import 'package:equatable/equatable.dart';

class PhoneVerificationRequest extends Equatable {
  final String phoneNumber;

  const PhoneVerificationRequest({required this.phoneNumber});

  Map<String, dynamic> toMap() {
    return {'phone': phoneNumber};
  }

  @override
  List<Object?> get props => [phoneNumber];
}
