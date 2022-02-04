import 'package:geolocator/geolocator.dart';
import 'package:volt/data/remote/geolocator/geolocator_service.dart';

class GeolocatorServiceImpl implements GeolocatorService {
  @override
  Future<Position> getCurrentPosition() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
  }
}
