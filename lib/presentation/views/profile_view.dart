import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profileVM = context.read<AppProfileVM>();

    return ResponsiveWidget(builder: (_, size) {
      return Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          image: const DecorationImage(
            image: AssetImage('assets/images/white_background.png'),
          ),
        ),
        child: Column(
          children: [
            const CustomSpacer(
              flex: 20,
            ),
            Container(
              height: 170.w,
              width: 170.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: Image.asset(
                    'assets/images/me.jpg',
                    fit: BoxFit.cover,
                  ).image,
                ),
              ),
            ),
            const CustomSpacer(
              flex: 5,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.w),
                    topRight: Radius.circular(40.w),
                  ),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: EdgeInsets.only(top: 10.h),
                        child: IconButton(
                            onPressed: () {
                              profileVM.navigateToEditProfileView();
                            },
                            icon: Icon(
                              Icons.border_color_outlined,
                              color: Theme.of(context).primaryColorLight,
                              size: 18.h,
                            )),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          height: 27.h,
                          width: 27.h,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorLight,
                              borderRadius: BorderRadius.circular(7.w)),
                          child: Icon(
                            IconlyLight.profile,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const CustomSpacer(
                          flex: 4,
                          horizontal: true,
                        ),
                        Text(
                          profileVM.name,
                          style: GoogleFonts.poppins(
                              color: Theme.of(context).primaryColorLight,
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp),
                        )
                      ],
                    ),
                    const CustomSpacer(
                      flex: 3,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 27.h,
                          width: 27.h,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorLight,
                              borderRadius: BorderRadius.circular(7.w)),
                          child: Icon(
                            IconlyLight.profile,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const CustomSpacer(
                          flex: 4,
                          horizontal: true,
                        ),
                        Text(
                          profileVM.number,
                          style: GoogleFonts.poppins(
                              color: Theme.of(context).primaryColorLight,
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp),
                        ),
                      ],
                    ),
                    const CustomSpacer(
                      flex: 3,
                    ),
                    const SupportContainer(),
                    const CustomSpacer(
                      flex: 5,
                    ),
                    Text(
                      'Terms and Conditions',
                      style: GoogleFonts.inter(
                          decoration: TextDecoration.underline,
                          color: Theme.of(context).primaryColorLight,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    const CustomSpacer(
                      flex: 3,
                    ),
                    Text(
                      'Version 1.0.0',
                      style: GoogleFonts.inter(
                          color: Theme.of(context).primaryColorLight,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    Container(
                        height: 45.h,
                        width: 90.w,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/volt_logo/volt_white.png')),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
