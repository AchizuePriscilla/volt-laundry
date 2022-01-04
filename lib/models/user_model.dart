import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String name;
  final String email;
  final String id;
  final String phoneNumber;
  final String address;
  final String country;
  final String state;
  final int vltCoinBalance;
  final int vltNairaBalance;

  const UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.phoneNumber,
      required this.address,
      required this.country,
      required this.state,
      required this.vltCoinBalance,
      required this.vltNairaBalance});

  factory UserModel.fromJson(Map json) {
    Map<String, dynamic> _json = Map<String, dynamic>.from(json);
    return UserModel(
      id: _json['id'] ?? '',
      name: _json['name'] ?? '',
      email: _json['email'] ?? '',
      phoneNumber: _json['phone'] ?? '',
      address: _json['location']['address'] ?? '',
      state: _json['location']['state'] ?? '',
      country: _json['location']['country'] ?? '',
      vltCoinBalance: _json['wallet']['VLT_COIN']['amount'] ?? '',
      vltNairaBalance: _json['wallet']['VLT_NGN']['amount'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phoneNumber,
      'name': name,
      'location': {
        "address": address,
        "state": state,
        "country": country,
      },
      'wallet': {
        'VLT_COIN': {'amount': vltCoinBalance},
        'VLT_NGN': {'amount': vltNairaBalance}
      }
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phoneNumber,
        address,
        country,
        state,
        vltCoinBalance,
        vltNairaBalance,
      ];
}
