import 'package:geolocator/geolocator.dart';

abstract class GeolocatorService {
  Future<Position> getCurrentPosition();
}

class GeolocatorServiceImpl implements GeolocatorService {
  @override
  Future<Position> getCurrentPosition() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
  }
}