import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt/models/dialog/dialog_request.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/constants.dart';

class FundWalletView extends StatelessWidget {
  const FundWalletView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var walletVM = context.read<WalletVM>();
    return ResponsiveWidget(builder: (_, size) {
      return Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  width: size.width,
                  // height: size.height * .35,
                  color: Theme.of(context).primaryColor,
                  child: Column(
                    children: [
                      const CustomSpacer(flex: 5),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CustomBackButton(
                            color: Theme.of(context).primaryColorLight),
                      ),
                      const CustomSpacer(flex: 1),
                      Container(
                        height: 40.h,
                        width: 105.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(23.w),
                            color: Theme.of(context).primaryColorLight),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const CustomSpacer(
                              flex: 1,
                              horizontal: true,
                            ),
                            SizedBox(
                              height: 20.h,
                              width: 20.h,
                              child: Image.asset(
                                  'assets/images/volt_coin_yellow.png'),
                            ),
                            const CustomSpacer(
                              flex: 2,
                              horizontal: true,
                            ),
                            Text(
                              'Volt Coin',
                              style: GoogleFonts.lato(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w800,
                                  color: Theme.of(context).primaryColor),
                            ),
                            IconButton(
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                ),
                                onPressed: () {
                                  walletVM.showDialog(
                                      DialogContentType.coinPicker,
                                      autoDismiss: false);
                                }),
                          ],
                        ),
                      ),
                      const CustomSpacer(flex: 2),
                      Text(
                        'VTC 500',
                        style: GoogleFonts.lato(
                            fontSize: 36.sp,
                            fontWeight: FontWeight.w900,
                            color: Theme.of(context).primaryColorLight),
                      ),
                      Text(
                        '2,500.00',
                        style: GoogleFonts.lato(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w300,
                            color: Theme.of(context).primaryColorLight),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 25.h),
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.w),
                    color: Palette.lightBlue,
                  ),
                  child: ListView(children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 33.h,
                            width: 33.h,
                            child: Image.asset(
                                'assets/images/volt_coin_yellow.png'),
                          ),
                          const CustomSpacer(
                            flex: 2,
                            horizontal: true,
                          ),
                          Text(
                            'Volt Coin',
                            style: GoogleFonts.lato(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '+50%',
                                style: GoogleFonts.lato(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Palette.lightGreen),
                              ),
                              Text(
                                'NGN200',
                                style: GoogleFonts.lato(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 33.h,
                            width: 33.h,
                            child: Image.asset(
                                'assets/images/volt_coin_yellow.png'),
                          ),
                          const CustomSpacer(
                            flex: 2,
                            horizontal: true,
                          ),
                          Text(
                            'Volt Coin',
                            style: GoogleFonts.lato(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '+50%',
                                style: GoogleFonts.lato(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Palette.lightGreen),
                              ),
                              Text(
                                'NGN200',
                                style: GoogleFonts.lato(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 33.h,
                            width: 33.h,
                            child: Image.asset(
                                'assets/images/volt_coin_yellow.png'),
                          ),
                          const CustomSpacer(
                            flex: 2,
                            horizontal: true,
                          ),
                          Text(
                            'Volt Coin',
                            style: GoogleFonts.lato(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '+50%',
                                style: GoogleFonts.lato(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Palette.lightGreen),
                              ),
                              Text(
                                'NGN200',
                                style: GoogleFonts.lato(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 33.h,
                            width: 33.h,
                            child: Image.asset(
                                'assets/images/volt_coin_yellow.png'),
                          ),
                          const CustomSpacer(
                            flex: 2,
                            horizontal: true,
                          ),
                          Text(
                            'Volt Coin',
                            style: GoogleFonts.lato(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '+50%',
                                style: GoogleFonts.lato(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Palette.lightGreen),
                              ),
                              Text(
                                'NGN200',
                                style: GoogleFonts.lato(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ]),
                ),
              )
            ],
          ),
          Positioned(
            top: size.height * (3 / 10) - 40.h / 2,
            left: 85.w,
            right: 85.w,
            child: Container(
              height: 40.h,
              width: size.width * .4,
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.w),
                color: const Color(0xff92C1D6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.restore,
                    size: 20.h,
                    color: Theme.of(context).primaryColorLight,
                  ),
                  Icon(
                    Icons.compare_arrows,
                    size: 20.h,
                    color: Theme.of(context).primaryColorLight,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 10.h),
              child: Button(
                text: 'Buy Volt Coin',
                onPressed: () {
                  walletVM.navigateToRoute(paymentMethodViewRoute);
                },
                color: Palette.lightGreen,
              ),
            ),
          )
        ],
      );
    });
  }
}
