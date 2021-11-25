import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/theme/palette.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';

class DeliveryDetailsView extends StatelessWidget {
  const DeliveryDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var laundryVM = context.read<LaundryVM>();
    return ResponsiveWidget(
        appBar: CustomAppBar(
          text: 'Checkout',
        ),
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
                    Icons.store,
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
                        'From Volt Store',
                        style: GoogleFonts.lato(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const CustomSpacer(
                        flex: 1,
                      ),
                      Text(
                        '13, University Road Nsukka',
                        style: GoogleFonts.lato(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
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
                    Icons.location_on,
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
                        'To',
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
                              'Plot 18, Jedidah Estate, Enugu',
                              style: GoogleFonts.lato(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Theme.of(context).disabledColor,
                              size: 14.h,
                            ),
                          ],
                        ),
                      ),
                      const CustomSpacer(
                        flex: 1,
                      ),
                      Row(
                        children: [
                          Text(
                            'Ade John  ',
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
                            '  08145518998',
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
              const CustomSpacer(flex: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                      value: 1,
                      groupValue: 1,
                      onChanged: (value) {},
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
                      value: 2,
                      groupValue: 2,
                      onChanged: (value) {},
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
                  Text(
                    'CHANGE',
                    style: GoogleFonts.lato(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).primaryColor),
                  ),
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
                  Icon(
                    Icons.credit_card,
                    color: Theme.of(context).primaryColor,
                  ),
                  const CustomSpacer(
                    flex: 3,
                    horizontal: true,
                  ),
                  Text(
                    '**** **** ***** 4664',
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
                    '7,500',
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
                    '500',
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
                    '8,000',
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
                  onPressed: () {
                    laundryVM.navigateToCheckoutView();
                  }),
              const CustomSpacer(flex: 4),
            ]),
          );
        });
  }
}
