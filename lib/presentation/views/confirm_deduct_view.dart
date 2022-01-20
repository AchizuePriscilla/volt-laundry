import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt/handlers/navigation_handler.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/constants.dart';
import 'package:volt/utils/locator.dart';

class ConfirmDeductView extends StatelessWidget {
  final double amount;
  const ConfirmDeductView({Key? key, required this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var laundryVM = context.read<LaundryVM>();
    var rxLaundryVM = context.watch<LaundryVM>();
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
                  loading: rxLaundryVM.loading,
                  onPressed: () async {
                    await laundryVM.processOrder();
                    locator<NavigationHandler>().popAndPushNamed(homeViewRoute);
                  },
                  color: Palette.lightGreen,
                ),
              ],
            ),
          );
        });
  }
}
