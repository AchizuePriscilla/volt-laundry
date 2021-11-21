import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var loginVM = context.read<LogInViewModel>();
    return ResponsiveWidget(
        appBar: CustomAppBar(),
        builder: (_, size) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Text(
                  'New Password',
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.w600, fontSize: 24.sp),
                ),
                const CustomSpacer(
                  flex: 3,
                ),
                const CustomTextField(
                  hint: 'Enter Code',
                ),
                const CustomSpacer(
                  flex: 3,
                ),
                const CustomTextField(
                  hint: 'Enter New Password',
                ),
                const CustomSpacer(
                  flex: 3,
                ),
                Button(
                    text: 'Reset',
                    onPressed: () {
                      loginVM.navigateToHomeView();
                    })
              ],
            ),
          );
        });
  }
}
