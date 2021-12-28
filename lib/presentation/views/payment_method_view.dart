import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/constants.dart';

class PaymentMethodView extends StatelessWidget {
  const PaymentMethodView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var walletVM = context.read<WalletVM>();
    return ResponsiveWidget(
        appBar: CustomAppBar(
          text: 'Payment Method',
        ),
        builder: (_, size) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                PaymentMethodRow(
                  label: 'Card Payment',
                  imagePath: 'mastercard',
                  onTap: () {
                    walletVM.navigateToRoute(checkoutViewRoute);
                  },
                ),
                const CustomSpacer(
                  flex: 2,
                ),
                PaymentMethodRow(
                  label: 'Bank Transfer',
                  imagePath: 'bank',
                  onTap: () {
                    walletVM.navigateToRoute(bankTransferViewRoute);
                  },
                ),
              ],
            ),
          );
        });
  }
}

class PaymentMethodRow extends StatelessWidget {
  const PaymentMethodRow({
    Key? key,
    required this.label,
    required this.onTap,
    required this.imagePath,
  }) : super(key: key);
  final String label;
  final VoidCallback onTap;
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(
            height: 50.h,
            width: 50.w,
            child: Image.asset('assets/images/$imagePath.png'),
          ),
          const CustomSpacer(
            flex: 3,
            horizontal: true,
          ),
          Text(
            label,
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
          ),
          const Spacer(),
          Container(
            height: 15.h,
            width: 15.h,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Color(0xffCBCBCB)),
          ),
        ],
      ),
    );
  }
}
