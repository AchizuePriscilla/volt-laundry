import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';

class FundVTCWalletView extends StatefulWidget {
  const FundVTCWalletView({Key? key}) : super(key: key);

  @override
  _FundVTCWalletViewState createState() => _FundVTCWalletViewState();
}

class _FundVTCWalletViewState extends State<FundVTCWalletView> {
  final _amountController = TextEditingController();
  bool buttonActive = false;
  late int _amount;
  void onListen() {
    if (_amountController.text.isEmpty) {
      setState(() {
        buttonActive = false;
      });
    } else {
      setState(() {
        buttonActive = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _amountController.addListener(onListen);
  }

  @override
  void dispose() {
    super.dispose();
    _amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var rxAppProfileVM = context.watch<AppProfileVM>();
    return ResponsiveWidget(builder: (context, size) {
      return SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              width: size.width,
              color: Theme.of(context).primaryColor,
              child: Column(
                children: [
                  const CustomSpacer(flex: 2),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomBackButton(
                        color: Theme.of(context).primaryColorLight),
                  ),
                  const CustomSpacer(flex: 2),
                  Text(
                    'VTC ${rxAppProfileVM.vltCoinBalance.toString()}',
                    style: GoogleFonts.lato(
                        fontSize: 36.sp,
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).primaryColorLight),
                  ),
                  Text(
                    "VNGN ${rxAppProfileVM.vltNairaBalance.toString()}",
                    style: GoogleFonts.lato(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w300,
                        color: Theme.of(context).primaryColorLight),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomSpacer(
                    flex: 4,
                  ),
                  Text(
                    'Convert VNGN to VTC for use within app',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const CustomSpacer(
                    flex: 6,
                  ),
                  Text(
                    'Amount to be converted',
                    style: GoogleFonts.lato(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const CustomSpacer(flex: 1),
                  CustomTextField(
                    hint: 'E.g: 8,000',
                    controller: _amountController,
                    onChanged: (value) {
                      _amount = int.parse(value);
                    },
                  ),
                  const CustomSpacer(flex: 4),
                  Align(
                    alignment: Alignment.center,
                    child: Button(
                        text: 'Convert',
                        active: buttonActive,
                        loading: context.watch<WalletVM>().loading,
                        onPressed: () {
                          context
                              .read<WalletVM>()
                              .creditVTCWallet(
                                  amount: _amount.toDouble(),
                                  onFailure: () {
                                    return ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.red,
                                        content: SizedBox(
                                          height: 30.h,
                                          child: Center(
                                            child: Text(
                                              'Something went wrong, please try again',
                                              style: TextStyle(fontSize: 14.sp),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                              .then((value) => _amountController.clear());
                        },
                        color: Palette.lightGreen),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
