import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt/models/process_order_model.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';

class ConfirmDeductView extends StatelessWidget {
  final double amount;
  final int deliveryFee;
  final bool isCartOrder;
  final bool isSingleCartOrder;
  final int? singleOrderIndex;
  final UserWear? userWear;
  const ConfirmDeductView(
      {Key? key,
      required this.amount,
      required this.deliveryFee,
      required this.isCartOrder,
      required this.isSingleCartOrder,
      this.singleOrderIndex,
      this.userWear})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var laundryVM = context.read<LaundryVM>();
    var rxLaundryVM = context.watch<LaundryVM>();
    var cartVM = context.read<CartVM>();
    var rxcartVM = context.watch<CartVM>();

    return ResponsiveWidget(
        appBar: CustomAppBar(
          text: 'Checkout',
        ),
        builder: (_, size) {
          return SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CustomSpacer(
                  flex: 10,
                ),
                Text(
                  '${amount.toString()} VTC',
                  style: GoogleFonts.lato(
                      fontSize: 50.sp,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).primaryColor),
                ),
                const CustomSpacer(
                  flex: 2,
                ),
                Text(
                  'Would be deducted from your account',
                  style: GoogleFonts.lato(
                      fontSize: 17.sp, fontWeight: FontWeight.w400),
                ),
                const CustomSpacer(
                  flex: 10,
                ),
                Button(
                  text: 'Confirm',
                  loading: isCartOrder ? rxcartVM.loading : rxLaundryVM.loading,
                  onPressed: () async {
                    log('Is Single order: $isSingleCartOrder');
                    isCartOrder && isSingleCartOrder
                        ? cartVM.processSingleOrder(
                            deliveryFee: deliveryFee, userWear: userWear!)
                        : isCartOrder
                            ? await cartVM.processOrder(
                                deliveryFee: deliveryFee,
                                totalPrice: cartVM.totalPrice,
                              )
                            : await laundryVM.processOrder(
                                deliveryFee: deliveryFee);
                  },
                  color: Palette.lightGreen,
                ),
              ],
            ),
          );
        });
  }
}
