import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/enums.dart';

class BuyCoinView extends StatefulWidget {
  const BuyCoinView({Key? key}) : super(key: key);

  @override
  _BuyCoinViewState createState() => _BuyCoinViewState();
}

class _BuyCoinViewState extends State<BuyCoinView> {
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
                                onPressed: () {}),
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
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomSpacer(
                          flex: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 30.h,
                              width: 105.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(23.w),
                                  color: Theme.of(context).primaryColor),
                              child: Row(
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
                                        color: Theme.of(context)
                                            .primaryColorLight),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                textAlign: TextAlign.end,
                                style: GoogleFonts.lato(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                ),
                                keyboardType: TextInputType.number,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '0.00',
                                    hintStyle: GoogleFonts.lato(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context)
                                            .disabledColor
                                            .withOpacity(.7))),
                              ),
                            )
                          ],
                        ),
                        const CustomSpacer(
                          flex: 4,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 30.h,
                              width: 120.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(23.w),
                                  color: Theme.of(context).primaryColor),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const CustomSpacer(
                                    flex: 2,
                                    horizontal: true,
                                  ),
                                  Text(
                                    'Select Source',
                                    style: GoogleFonts.lato(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w800,
                                        color: Theme.of(context)
                                            .primaryColorLight),
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.keyboard_arrow_down,
                                          color: Theme.of(context)
                                              .primaryColorLight),
                                      onPressed: () {}),
                                ],
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                textAlign: TextAlign.end,
                                style: GoogleFonts.lato(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                ),
                                keyboardType: TextInputType.number,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '0.00',
                                    hintStyle: GoogleFonts.lato(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context)
                                            .disabledColor
                                            .withOpacity(.7))),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ))
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 10.h),
              child: Button(
                text: 'Buy Volt Coin',
                onPressed: () {
                  walletVM.showDialog(DialogContentType.transactionComplete);
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
