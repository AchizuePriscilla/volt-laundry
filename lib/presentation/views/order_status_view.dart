import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt/handlers/handlers.dart';
import 'package:volt/models/navigation/map_view_args.dart';
import 'package:volt/models/order_history_model.dart';
import 'package:volt/models/user_model.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/presentation/views/views.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:volt/utils/constants.dart';
import 'package:volt/utils/locator.dart';

class OrderStatusView extends StatefulWidget {
  const OrderStatusView({Key? key}) : super(key: key);

  @override
  _OrderStatusViewState createState() => _OrderStatusViewState();
}

class _OrderStatusViewState extends State<OrderStatusView> {
  bool isDropdownVisible = true;
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        appBar: CustomAppBar(
          text: 'Order Status',
          automaticallyLead: false,
        ),
        builder: (_, size) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Progress Status',
                    style: GoogleFonts.lato(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Palette.blackColor),
                  ),
                ),
                const CustomSpacer(
                  flex: 2,
                ),
                FutureBuilder<List<Order>>(
                    future: context.watch<LaundryVM>().getOrderHistory(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var orders = snapshot.data;
                        return Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              await context.read<LaundryVM>().getOrderHistory();
                            },
                            child: orders!.isEmpty
                                ? const NoLaundryView()
                                : ListView.builder(
                                    itemBuilder: (context, index) {
                                      context
                                          .read<LaundryVM>()
                                          .getDriverDetails(
                                              orders[index].assignedTo);
                                      return OrderStatusDropdown(
                                        onTap: () {
                                          setState(() {
                                            selectedIndex == index
                                                ? selectedIndex = null
                                                : selectedIndex = index;
                                          });
                                        },
                                        onButtonTap: () {
                                          setState(() {
                                            selectedIndex == index
                                                ? selectedIndex = null
                                                : selectedIndex = index;
                                          });
                                        },
                                        driver: context
                                            .watch<LaundryVM>()
                                            .driverDetails,
                                        isDropdownVisible:
                                            selectedIndex == index
                                                ? true
                                                : false,
                                        order: orders[index],
                                      );
                                    },
                                    itemCount: orders.length,
                                  ),
                          ),
                        );
                      }
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text('Sorry, an error occured, try again'),
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    }),
              ],
            ),
          );
        });
  }
}

class OrderStatusDropdown extends StatefulWidget {
  const OrderStatusDropdown(
      {Key? key,
      required this.isDropdownVisible,
      required this.order,
      required this.onTap,
      required this.onButtonTap,
      required this.driver})
      : super(key: key);

  final bool isDropdownVisible;
  final VoidCallback onTap;
  final VoidCallback onButtonTap;
  final Order order;
  final UserModel driver;

  @override
  State<OrderStatusDropdown> createState() => _OrderStatusDropdownState();
}

class _OrderStatusDropdownState extends State<OrderStatusDropdown> {
  @override
  Widget build(BuildContext context) {
    var latitude = context.watch<AppProfileVM>().latitude!;
    var longitude = context.watch<AppProfileVM>().longitude!;
    LatLng userPosition = LatLng(latitude, longitude);
    LatLng driverPosition = LatLng(
        widget.order.currentLocation.lat, widget.order.currentLocation.lng);
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
        CameraPosition(target: LatLng(latitude, longitude), zoom: 13);

    Polyline polyline = Polyline(
        color: Palette.buttonColor,
        width: 5,
        jointType: JointType.round,
        polylineId: const PolylineId('kPolyline'),
        points: [userPosition, driverPosition]);
    return InkWell(
      onTap: widget.onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.w),
              color: Palette.lightBlue,
            ),
            margin: EdgeInsets.symmetric(vertical: 5.h),
            padding: EdgeInsets.all(5.h),
            child: Row(
              children: [
                const CustomSpacer(
                  flex: 5,
                  horizontal: true,
                ),
                Text(
                  'Order No',
                  style: GoogleFonts.lato(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const CustomSpacer(flex: 2, horizontal: true),
                Text(
                  widget.order.orderNo,
                  style: GoogleFonts.lato(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Expanded(child: SizedBox()),
                IconButton(
                  onPressed: widget.onButtonTap,
                  icon: Icon(
                      widget.isDropdownVisible
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      size: 22.h),
                ),
              ],
            ),
          ),
          Visibility(
            visible: widget.isDropdownVisible,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OrderStageContainer(
                  imagePath: 'bike',
                  orderStage: 'Order Picked',
                  isDotVisible: widget.order.status == 'PLACED' ||
                      widget.order.status == 'ASSIGNED' ||
                      widget.order.status == 'PICKED' ||
                      widget.order.status == 'IN-PROGRESS' ||
                      widget.order.status == 'DELIVERING' ||
                      widget.order.status == 'DELIVERED',
                  dotColor: widget.order.status == 'PLACED' ||
                          widget.order.status == 'ASSIGNED'
                      ? Colors.yellow
                      : Palette.lightGreen,
                ),
                Row(
                  children: [
                    const CustomSpacer(flex: 6, horizontal: true),
                    Container(
                      height: 35.h,
                      width: 1,
                      color: Theme.of(context).disabledColor,
                    ),
                  ],
                ),
                OrderStageContainer(
                  imagePath: 'wash',
                  orderStage: 'Cleaning',
                  isDotVisible: widget.order.status == 'IN-PROGRESS' ||
                      widget.order.status == 'DELIVERING' ||
                      widget.order.status == 'DELIVERED',
                  dotColor: widget.order.status == 'IN-PROGRESS'
                      ? Colors.yellow
                      : Palette.lightGreen,
                ),
                Row(
                  children: [
                    const CustomSpacer(flex: 6, horizontal: true),
                    Container(
                      height: 35.h,
                      width: 1,
                      color: Theme.of(context).disabledColor,
                    ),
                  ],
                ),
                OrderStageContainer(
                  imagePath: 'bike',
                  orderStage: 'Courier is on the way',
                  hasArrivalTime: true,
                  isDotVisible: widget.order.status == 'DELIVERING' ||
                      widget.order.status == 'DELIVERED',
                  dotColor: widget.order.status == 'DELIVERING'
                      ? Colors.yellow
                      : Palette.lightGreen,
                ),
                const CustomSpacer(
                  flex: 2,
                ),
                Visibility(
                  visible: widget.order.status == 'DELIVERING',
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * .5,
                    child: GoogleMap(
                      mapType: MapType.terrain,
                      initialCameraPosition: cameraPosition,
                      trafficEnabled: true,
                      markers: {userPositionMarker, driverPositionMarker},
                      polylines: {polyline},
                      onTap: (latlng) {
                        locator<NavigationHandler>().pushNamed(
                          mapViewRoute,
                          arg: MapViewArgs(order: widget.order),
                        );
                      },
                    ),
                  ),
                ),
                const CustomSpacer(
                  flex: 2,
                ),
                Visibility(
                  visible: widget.order.status == 'ASSIGNED',
                  child: Column(
                    children: [
                      Row(children: [
                        CircleAvatar(
                          radius: 27.w,
                          backgroundImage: widget.driver.avatar == null ||
                                  widget.driver.avatar!.isEmpty ||
                                  widget.driver.avatar == "undefined"
                              ? const AssetImage(
                                  'assets/images/empty_profile_picture.png')
                              : NetworkImage(widget.driver.avatar!)
                                  as ImageProvider,
                        ),
                        const CustomSpacer(flex: 2, horizontal: true),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.driver.name!,
                              style: GoogleFonts.lato(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Courier',
                              style: GoogleFonts.lato(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        const Expanded(child: SizedBox()),
                        Text(
                          'Close',
                          style: GoogleFonts.lato(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Palette.buttonColor),
                        ),
                      ]),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.driver.phoneNumber!,
                              style: GoogleFonts.lato(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            // const CustomSpacer(flex: 2),
                            // Text(
                            //   'Black in complexion',
                            //   style: GoogleFonts.lato(
                            //     fontSize: 14.sp,
                            //     fontWeight: FontWeight.w400,
                            //   ),
                            // ),
                            // const CustomSpacer(flex: 2),
                            // Text(
                            //   'Tall',
                            //   style: GoogleFonts.lato(
                            //     fontSize: 14.sp,
                            //     fontWeight: FontWeight.w400,
                            //   ),
                            // ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OrderStageContainer extends StatelessWidget {
  final String imagePath;
  final String orderStage;
  final bool? hasArrivalTime;
  final bool isDotVisible;
  final Color dotColor;
  const OrderStageContainer(
      {Key? key,
      required this.imagePath,
      required this.orderStage,
      this.hasArrivalTime = false,
      required this.isDotVisible,
      required this.dotColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            Container(
              padding: EdgeInsets.all(15.w),
              margin: EdgeInsets.symmetric(vertical: 2.h),
              height: 50.h,
              width: 50.h,
              decoration: BoxDecoration(
                color: Palette.buttonColor,
                borderRadius: BorderRadius.circular(10.w),
              ),
              child: Image.asset('assets/images/volt_$imagePath.png'),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Visibility(
                visible: isDotVisible,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  height: 10,
                  width: 10,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: dotColor),
                ),
              ),
            )
          ],
        ),
        const CustomSpacer(flex: 3, horizontal: true),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              orderStage,
              style: GoogleFonts.lato(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: Palette.blackColor),
            ),
            if (hasArrivalTime!)
              Visibility(
                visible: orderStage == 'DELIVERING',
                child: Text(
                  'Arrival is in 5 minutes',
                  style: GoogleFonts.lato(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w300,
                      color: Palette.blackColor),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
