import 'package:geolocator/geolocator.dart';

abstract class GeolocatorService {
  Future<Position> getCurrentPosition();
}
