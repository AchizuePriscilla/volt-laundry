import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt/models/order_history_model.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/presentation/views/views.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
                    future: context.read<LaundryVM>().getOrderHistory(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var orders = snapshot.data;
                        return Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              await context.read<LaundryVM>().getOrderHistory();
                            },
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return orders!.isEmpty
                                    ? const NoLaundryView()
                                    : OrderStatusDropdown(
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
                                        isDropdownVisible:
                                            selectedIndex == index
                                                ? true
                                                : false,
                                        order: orders[index],
                                      );
                              },
                              itemCount: orders!.isEmpty ? 1 : orders.length,
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
      required this.onButtonTap})
      : super(key: key);

  final bool isDropdownVisible;
  final VoidCallback onTap;
  final VoidCallback onButtonTap;
  final Order order;

  @override
  State<OrderStatusDropdown> createState() => _OrderStatusDropdownState();
}

class _OrderStatusDropdownState extends State<OrderStatusDropdown> {
  @override
  Widget build(BuildContext context) {
    var latitude = context.watch<AppProfileVM>().latitude!;
    var longitude = context.watch<AppProfileVM>().longitude!;
    Marker userPositionMarker = Marker(
        markerId: const MarkerId('userPosition'),
        infoWindow: const InfoWindow(title: 'My Position'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        position: LatLng(latitude, longitude));
    Marker driverPositionMarker = Marker(
        markerId: const MarkerId('driverPosition'),
        infoWindow: const InfoWindow(title: 'Courier Position'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: LatLng(widget.order.currentLocation.lat,
            widget.order.currentLocation.lng));

    CameraPosition userPosition =
        CameraPosition(target: LatLng(latitude, longitude), zoom: 15);
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
                const OrderStageContainer(
                  imagePath: 'bike',
                  orderStage: 'Order Picked',
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
                const OrderStageContainer(
                  imagePath: 'wash',
                  orderStage: 'Cleaning',
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
                const OrderStageContainer(
                  imagePath: 'bike',
                  orderStage: 'Courier is on the way',
                  hasArrivalTime: true,
                ),
                const CustomSpacer(
                  flex: 2,
                ),
                Visibility(
                  visible: widget.order.status == 'PLACED',
                  child: Container(
                    height: MediaQuery.of(context).size.height * .5,
                    color: Colors.red,
                    child: GoogleMap(
                      mapType: MapType.terrain,
                      initialCameraPosition: userPosition,
                      markers: {userPositionMarker, driverPositionMarker},
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
                          backgroundImage: const AssetImage(
                              'assets/images/empty_profile_picture.png'),
                        ),
                        const CustomSpacer(flex: 2, horizontal: true),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Paul David',
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
                              '08145518998',
                              style: GoogleFonts.lato(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const CustomSpacer(flex: 2),
                            Text(
                              'Black in complexion',
                              style: GoogleFonts.lato(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const CustomSpacer(flex: 2),
                            Text(
                              'Tall',
                              style: GoogleFonts.lato(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
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
  const OrderStageContainer(
      {Key? key,
      required this.imagePath,
      required this.orderStage,
      this.hasArrivalTime = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
              Text(
                'Arrival is in 5 minutes',
                style: GoogleFonts.lato(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w300,
                    color: Palette.blackColor),
              ),
          ],
        ),
      ],
    );
  }
}
