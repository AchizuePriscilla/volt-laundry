import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:volt/presentation/viewmodels/sign_up_view_model.dart';

class AddressSearchView extends StatefulWidget {
  const AddressSearchView({Key? key}) : super(key: key);

  @override
  _AddressSearchViewState createState() => _AddressSearchViewState();
}

class _AddressSearchViewState extends State<AddressSearchView> {
  @override
  Widget build(BuildContext context) {
    var signUpVM = context.read<SignUpViewModel>();
    return ResponsiveWidget(
      builder: (context, size) {
        return Column(
          children: [
           const CustomSpacer(
              flex: 4,
            ),
            CustomTextField(
              fillColor: Theme.of(context).primaryColorLight,
              prefix: Icon(
                Icons.search,
                color: Theme.of(context).disabledColor.withOpacity(.6),
              ),
              hint: "Search Location",
            ),
            Expanded(
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(signUpVM.currentPosition.latitude,
                        signUpVM.currentPosition.longitude),
                    zoom: 15),
                mapType: MapType.normal,
                myLocationEnabled: true,
              ),
            ),
          ],
        );
      },
    );
  }
}
