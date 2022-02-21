
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/utils.dart';

class DeliveryDetailsView extends StatefulWidget {
  final int numberOfWears;
  final bool isCartOrder;
  final bool? isSingleCartOrder;
  final int? singleOrderIndex;
  const DeliveryDetailsView(
      {Key? key, required this.numberOfWears, required this.isCartOrder,
      this.isSingleCartOrder = false,
      this.singleOrderIndex})
      : super(key: key);

  @override
  State<DeliveryDetailsView> createState() => _DeliveryDetailsViewState();
}

class _DeliveryDetailsViewState extends State<DeliveryDetailsView> {
  DeliveryMethod deliveryMethod = DeliveryMethod.pickup;

  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    var laundryVM = context.read<LaundryVM>();
    var profileVM = context.watch<AppProfileVM>();
    var rxLaundryVM = context.watch<LaundryVM>();
    var cartVM = context.watch<CartVM>();

    int _deliveryFee = deliveryMethod == DeliveryMethod.pickup ? 20 : 0;
    double _total = ((widget.numberOfWears * 50) + _deliveryFee).toDouble();

    return ResponsiveWidget(
        appBar: CustomAppBar(
          text: 'Checkout',
        ),
        scaffoldKey: _scaffoldKey,
        builder: (_, size) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Delivery Details',
                style: GoogleFonts.lato(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const CustomSpacer(
                flex: 4,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on,
                    color: Palette.buttonColor,
                    size: 20.h,
                  ),
                  const CustomSpacer(
                    flex: 3,
                    horizontal: true,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'From',
                        style: GoogleFonts.lato(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const CustomSpacer(
                        flex: 1,
                      ),
                      Text(
                        profileVM.address,
                        style: GoogleFonts.lato(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '${profileVM.name}  ',
                            style: GoogleFonts.lato(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Container(
                            height: 3.h,
                            width: 3.h,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).disabledColor),
                          ),
                          Text(
                            '  ${profileVM.number}',
                            style: GoogleFonts.lato(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
              const CustomSpacer(
                flex: 2,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.store,
                    color: Palette.lightGreen,
                    size: 20.h,
                  ),
                  const CustomSpacer(
                    flex: 3,
                    horizontal: true,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'To Volt Store',
                        style: GoogleFonts.lato(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const CustomSpacer(
                        flex: 1,
                      ),
                      SizedBox(
                        width: size.width * .7,
                        child: Row(
                          // mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '13, University Road Nsukka',
                              style: GoogleFonts.lato(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            // Icon(
                            //   Icons.arrow_forward_ios,
                            //   color: Theme.of(context).disabledColor,
                            //   size: 14.h,
                            // ),
                          ],
                        ),
                      ),
                      const CustomSpacer(
                        flex: 1,
                      ),
                    ],
                  )
                ],
              ),
              const CustomSpacer(flex: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio<DeliveryMethod>(
                      value: DeliveryMethod.pickup,
                      groupValue: deliveryMethod,
                      toggleable: true,
                      onChanged: (DeliveryMethod? newValue) {
                        setState(() {
                          deliveryMethod = newValue!;
                        });

                        widget.isCartOrder
                            ? cartVM.setDeliveryMethod(deliveryMethod)
                            : laundryVM.setDeliveryMethod(deliveryMethod);
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
                  const CustomSpacer(
                    flex: 2,
                    horizontal: true,
                  ),
                  Text(
                    'Door Pickup',
                    style: GoogleFonts.lato(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const CustomSpacer(flex: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                      value: DeliveryMethod.dropOff,
                      groupValue: deliveryMethod,
                      toggleable: true,
                      onChanged: (DeliveryMethod? newValue) {
                        setState(() {
                          deliveryMethod = newValue!;
                        });
                        widget.isCartOrder
                            ? cartVM.setDeliveryMethod(deliveryMethod)
                            : laundryVM.setDeliveryMethod(deliveryMethod);
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
                  const CustomSpacer(
                    flex: 2,
                    horizontal: true,
                  ),
                  Text(
                    'Office Drop off',
                    style: GoogleFonts.lato(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
              const CustomSpacer(flex: 2),
              Divider(
                thickness: 1,
                color: Theme.of(context).disabledColor,
              ),
              const CustomSpacer(flex: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Payment Method',
                    style: GoogleFonts.lato(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  // Text(
                  //   'CHANGE',
                  //   style: GoogleFonts.lato(
                  //       fontSize: 16.sp,
                  //       fontWeight: FontWeight.w700,
                  //       color: Theme.of(context).primaryColor),
                  // ),
                ],
              ),
              const CustomSpacer(
                flex: 4,
              ),
              Row(
                children: [
                  const CustomSpacer(
                    flex: 3,
                    horizontal: true,
                  ),
                  Container(
                    height: 20.h,
                    width: 20.h,
                    padding: EdgeInsets.all(2.h),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1,
                      ),
                    ),
                    child: Image.asset('assets/images/volt.png'),
                  ),
                  const CustomSpacer(
                    flex: 3,
                    horizontal: true,
                  ),
                  Text(
                    'Volt coin',
                    style: GoogleFonts.lato(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
              const CustomSpacer(flex: 3),
              Divider(
                thickness: 1,
                color: Theme.of(context).disabledColor,
              ),
              const CustomSpacer(flex: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Price',
                    style: GoogleFonts.lato(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '${_total.toString()} VTC',
                    style: GoogleFonts.lato(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const CustomSpacer(flex: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Delivery fee',
                    style: GoogleFonts.lato(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    deliveryMethod == DeliveryMethod.dropOff ? '00' : '20',
                    style: GoogleFonts.lato(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const CustomSpacer(flex: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: GoogleFonts.lato(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '${_total.toString()} VTC',
                    style: GoogleFonts.lato(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const CustomSpacer(flex: 7),
              Button(
                  text: 'Proceed',
                  loading:
                      widget.isCartOrder ? cartVM.loading : rxLaundryVM.loading,
                  onPressed: () async {
                    widget.isCartOrder
                        ? await cartVM.transactionInit(
                            email: profileVM.email!,
                            deliveryFee: _deliveryFee,
                            scaffoldKey: _scaffoldKey,
                            amount: _total,
                            isSingleCartOrder: widget.isSingleCartOrder,
                            singleOrderIndex: widget.singleOrderIndex
                          )
                        : await laundryVM.transactionInit(
                            email: profileVM.email!,
                            deliveryFee: _deliveryFee,
                            scaffoldKey: _scaffoldKey,
                            amount: _total,
                          );
                  }),
              const CustomSpacer(flex: 4),
            ]),
          );
        });
  }
}
