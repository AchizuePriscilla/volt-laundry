import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:volt/models/order_history_model.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/app_profile_view_model.dart';
import 'package:volt/utils/logger.dart';

import '../../data/config/base_api.dart';

class MapWidget extends StatefulWidget {
  final Order order;
  final Function(LatLng position)? onTap;
  const MapWidget({Key? key, required this.order, this.onTap}) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
 final Set<Marker> _markers = <Marker>{};
  late LatLng currentLocation;
  late LatLng destinationLocation;
  final Set<Polyline> _polylines = <Polyline>{};
  final Completer<GoogleMapController> _controller = Completer();
  Location location = Location();
  void setInitialLocation() {
    var _rxUserVM = context.read<AppProfileVM>();
    var latitude = _rxUserVM.currenLocation.latitude;
    var longitude = _rxUserVM.currenLocation.longitude;
    currentLocation = LatLng(latitude!, longitude!);
    destinationLocation =
        LatLng(widget.order.origin.lat, widget.order.origin.lng);
  }

  @override
  void initState() {
    setInitialLocation();
    super.initState();
  }

  void updatePinOnMap() async {
    CameraPosition cPosition = CameraPosition(
      zoom: 16,
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));

    setState(() {
      var pinPosition =
          LatLng(currentLocation.latitude, currentLocation.longitude);
      _markers.removeWhere((m) => m.markerId.value == 'driverPosition');
      _markers.add(Marker(
          markerId: const MarkerId('driverPosition'),
          infoWindow: const InfoWindow(title: 'My Position'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pinPosition));
    });
  }

  void getCurrentLocationAndUpdatePin() {
    location.onLocationChanged.listen((LocationData cLoc) {
      currentLocation = LatLng(cLoc.latitude!, cLoc.longitude!);
      updatePinOnMap();
    });
  }

  @override
  Widget build(BuildContext context) {
    getCurrentLocationAndUpdatePin();
    void showMarker() {
      setState(() {
        _markers.add(Marker(
            markerId: const MarkerId('userPosition'),
            infoWindow: const InfoWindow(title: 'Order Position'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure),
            position: destinationLocation));

        _markers.add(Marker(
            markerId: const MarkerId('driverPosition'),
            infoWindow: const InfoWindow(title: 'My Position'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
            position: currentLocation));
      });
    }

    _getPolyline() async {
      try {
        PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          BaseApi.getGoogleApiKey(),
          PointLatLng(currentLocation.latitude, currentLocation.longitude),
          PointLatLng(widget.order.origin.lat, widget.order.origin.lng),
          travelMode: TravelMode.driving,
        );
        if (result.points.isNotEmpty) {
          for (var point in result.points) {
            polylineCoordinates.add(LatLng(point.latitude, point.longitude));
          }
          setState(() {
            _polylines.add(Polyline(
                color: Palette.buttonColor,
                width: 5,
                jointType: JointType.bevel,
                polylineId: const PolylineId('kPolyline'),
                points: polylineCoordinates));
          });
        }
      } catch (e) {
        AppLogger.logger.d(e);
      }
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        onTap: widget.onTap ?? (position){},
        mapType: MapType.terrain,
        initialCameraPosition: CameraPosition(
            target: LatLng(currentLocation.latitude, currentLocation.longitude),
            zoom: 12),
        zoomControlsEnabled: false,
        trafficEnabled: true,
        onMapCreated: (controller) async {
          _controller.complete(controller);
          showMarker();
          await _getPolyline();
        },
        markers: _markers,
        polylines: _polylines,
      ),
    );
  }
}
