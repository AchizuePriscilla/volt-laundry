import 'package:equatable/equatable.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';

class GetDirectionsRequest extends Equatable {
    final LatLng origin;
  final LatLng destination;

  const GetDirectionsRequest({required this.origin, required this.destination});
  Map<String, dynamic> toMap() {
    return {
     
    };
  }

  @override
  List<Object?> get props => [origin, destination];
}