import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:provider/provider.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/utils.dart';

class WalletView extends StatefulWidget {
  const WalletView({Key? key}) : super(key: key);

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  @override
  Widget build(BuildContext context) {
    var walletVM = context.read<WalletVM>();
    return ResponsiveWidget(
      appBar: CustomAppBar(
        text: 'Wallet',
      ),
      builder: (_, size) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            children: [
              const CreditCard(),
              const CustomSpacer(flex: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 60.h,
                    width: size.width * .38,
                    color: Theme.of(context).primaryColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Balance',
                          style: GoogleFonts.poppins(
                              color: Theme.of(context).primaryColorLight,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w400),
                        ),
                        const CustomSpacer(
                          flex: 1,
                        ),
                        Text(
                          '₦17,000.00',
                          style: GoogleFonts.roboto(
                              color: Theme.of(context).primaryColorLight,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      walletVM.navigateToRoute(fundWalletViewRoute);
                    },
                    child: Container(
                      height: 60.h,
                      width: size.width * .38,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorLight,
                          border: Border.all(
                              color: Theme.of(context).primaryColor, width: 2)),
                      child: Center(
                        child: Text(
                          'Fund\nWallet',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              color: Theme.of(context).primaryColor,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const CustomSpacer(
                flex: 3,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'History',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400, fontSize: 18.sp),
                ),
              ),
              Expanded(
                child: SizedBox(
                  child: ListView(
                    children: const [
                      // TransactionHistory(serviceType: ServiceType.ironing),
                      // TransactionHistory(serviceType: ServiceType.washAndIron),
                      // TransactionHistory(serviceType: ServiceType.dryCleaning),
                      // TransactionHistory(serviceType: ServiceType.ironing),
                      // TransactionHistory(serviceType: ServiceType.ironing),
                      // TransactionHistory(serviceType: ServiceType.washAndIron),
                      // TransactionHistory(serviceType: ServiceType.dryCleaning),
                      // TransactionHistory(serviceType: ServiceType.ironing)
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
