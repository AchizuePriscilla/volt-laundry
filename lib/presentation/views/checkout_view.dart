import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/enums.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({Key? key}) : super(key: key);

  @override
  _CheckoutViewState createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  @override
  Widget build(BuildContext context) {
    var walletVM = context.read<WalletVM>();
    return ResponsiveWidget(
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar(
          text: 'Card Payment',
        ),
        builder: (_, size) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CreditCard(),
                  const CustomSpacer(flex: 3),
                  Text(
                    'Name on Card',
                    style: GoogleFonts.lato(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const CustomSpacer(flex: 1),
                  const CustomTextField(
                    hint: 'E.g: Ade John',
                  ),
                  const CustomSpacer(flex: 3),
                  Text(
                    'Card Number',
                    style: GoogleFonts.lato(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const CustomSpacer(flex: 1),
                  CustomTextField(
                    hint: 'E.g: 4747 6797 8973 7989',
                    suffix: Container(
                      padding: EdgeInsets.only(right: 10.w),
                      height: 16.h,
                      width: 26.h,
                      child: Image.asset('assets/images/mastercard.png'),
                    ),
                  ),
                  const CustomSpacer(flex: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Expiry Date',
                            style: GoogleFonts.lato(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const CustomSpacer(flex: 1),
                          SizedBox(
                            width: size.width * .4,
                            child: const CustomTextField(
                              hint: 'E.g: 07/21',
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CVC',
                            style: GoogleFonts.lato(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const CustomSpacer(flex: 1),
                          SizedBox(
                            width: size.width * .4,
                            child: const CustomTextField(
                              hint: 'E.g: 234',
                              suffix: Icon(Icons.credit_card,
                                  color: Palette.orangeColor),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const CustomSpacer(flex: 3),
                  Text(
                    'Amount',
                    style: GoogleFonts.lato(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const CustomSpacer(flex: 1),
                  const CustomTextField(
                    hint: 'E.g: 8,000',
                  ),
                  const CustomSpacer(flex: 4),
                  Align(
                    alignment: Alignment.center,
                    child: Button(
                        text: 'Pay',
                        onPressed: () {
                          walletVM.showDialog(
                              DialogContentType.transactionComplete);
                        },
                        color: Palette.lightGreen),
                  ),
                  const CustomSpacer(flex: 3),
                ],
              ),
            ),
          );
        });
  }
}
