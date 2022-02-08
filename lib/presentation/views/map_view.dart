import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:volt/models/order_history_model.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/app_profile_view_model.dart';

class MapView extends StatelessWidget {
  final Order order;
  const MapView({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var latitude = context.watch<AppProfileVM>().latitude!;
    var longitude = context.watch<AppProfileVM>().longitude!;
    LatLng userPosition = LatLng(latitude, longitude);
    LatLng driverPosition =
        LatLng(order.currentLocation.lat, order.currentLocation.lng);
    Marker userPositionMarker = Marker(
        markerId: const MarkerId('userPosition'),
        infoWindow: const InfoWindow(title: 'My Position'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        position: userPosition);

    Marker driverPositionMarker = Marker(
        markerId: const MarkerId('driverPosition'),
        infoWindow: const InfoWindow(title: 'Courier Position'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: driverPosition);

    CameraPosition cameraPosition =
        CameraPosition(target: LatLng(latitude, longitude), zoom: 15);

    Polyline polyline = Polyline(
        color: Palette.buttonColor,
        width: 5,
        jointType: JointType.round,
        polylineId: const PolylineId('kPolyline'),
        points: [userPosition, driverPosition]);
    return ResponsiveWidget(builder: (context, size) {
      return SizedBox(
        height: size.height,
        width: size.width,
        child: GoogleMap(
          mapType: MapType.terrain,
          initialCameraPosition: cameraPosition,
          trafficEnabled: true,
          markers: {userPositionMarker, driverPositionMarker},
          polylines: {polyline},
        ),
      );
    });
  }
}
