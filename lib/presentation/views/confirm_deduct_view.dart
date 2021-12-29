import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt/handlers/navigation_handler.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/constants.dart';
import 'package:volt/utils/enums.dart';
import 'package:volt/utils/locator.dart';

class ConfirmDeductView extends StatelessWidget {
  const ConfirmDeductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  '90 VTC',
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
                  onPressed: () {
                    context
                        .read<WalletVM>()
                        .showDialog(DialogContentType.success);
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
