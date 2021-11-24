import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/utils.dart';

class SignInAs extends StatelessWidget {
  const SignInAs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var verificationVM = context.read<VerificationViewModel>();
    return ResponsiveWidget(builder: (_, size) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Log In as:',
              style: GoogleFonts.lato(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            const CustomSpacer(
              flex: 3,
            ),
            Button(
              text: 'Customer',
              onPressed: () {
                verificationVM.navigateToRoute(signUpViewRoute);
              },
              isRounded: true,
            ),
            const CustomSpacer(
              flex: 2,
            ),
            Button(
              text: 'Driver',
              onPressed: () {
                verificationVM.navigateToRoute(signUpViewRoute);
              },
              isRounded: true,
            ),
          ],
        ),
      );
    });
  }
}
