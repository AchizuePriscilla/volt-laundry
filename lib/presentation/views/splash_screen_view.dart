import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:volt/presentation/shared/shared.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (_, size) {
        return Stack(
          children: [
            Container(
              height: size.height,
              width: size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/blue_background.png'),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                height: 200.h,
                width: 200.w,
                child: Image.asset('assets/images/volt_logo/volt_white.png'),
              ),
            ),
          ],
        );
      },
    );
  }
}
