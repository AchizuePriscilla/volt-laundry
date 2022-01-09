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
  final _formKey = GlobalKey<FormState>();

  final _cardNumberController = TextEditingController();
  final _expiryMonthController = TextEditingController();
  final _expiryYearController = TextEditingController();
  final _nameController = TextEditingController();
  final _cvvController = TextEditingController();
  final _amountController = TextEditingController();
  bool buttonActive = false;

  void onListen() {
    if (_expiryMonthController.text.isEmpty ||
        _cardNumberController.text.isEmpty ||
        _expiryYearController.text.isEmpty ||
        _nameController.text.isEmpty ||
        _cvvController.text.isEmpty ||
        _amountController.text.isEmpty) {
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
    _expiryMonthController.addListener(onListen);
    _cardNumberController.addListener(onListen);
    _expiryYearController.addListener(onListen);
    _nameController.addListener(onListen);
    _cvvController.addListener(onListen);
    _amountController.addListener(onListen);
  }

  @override
  void dispose() {
    _expiryMonthController.removeListener(onListen);
    _cardNumberController.removeListener(onListen);
    _expiryYearController.removeListener(onListen);
    _nameController.removeListener(onListen);
    _cvvController.removeListener(onListen);
    _amountController.removeListener(onListen);
    super.dispose();
  }

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
              child: Form(
                key: _formKey,
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
                    CustomTextField(
                      hint: 'E.g: Ade John',
                      validator: (name) {
                        return walletVM.validateFullName(name);
                      },
                      controller: _nameController,
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
                      validator: (cardNumber) {
                        return walletVM.validateCardNumber(cardNumber);
                      },
                      controller: _cardNumberController,
                      // suffix: Container(
                      //   padding: EdgeInsets.only(right: 10.w),
                      //   height: 16.h,
                      //   width: 26.h,
                      //   child: Image.asset('assets/images/mastercard.png'),
                      // ),
                    ),
                    const CustomSpacer(flex: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Expiry Month',
                              style: GoogleFonts.lato(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            const CustomSpacer(flex: 1),
                            SizedBox(
                              width: size.width * .4,
                              child: CustomTextField(
                                validator: (expiryMonth) {
                                  return walletVM
                                      .validateExpiryMonth(expiryMonth);
                                },
                                controller: _expiryMonthController,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Expiry Year',
                              style: GoogleFonts.lato(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            const CustomSpacer(flex: 1),
                            SizedBox(
                              width: size.width * .4,
                              child: CustomTextField(
                                validator: (expiryYear) {
                                  return walletVM
                                      .validateExpiryYear(expiryYear);
                                },
                                controller: _expiryYearController,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const CustomSpacer(flex: 3),
                    Text(
                      'CVV',
                      style: GoogleFonts.lato(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const CustomSpacer(flex: 1),
                    SizedBox(
                      width: size.width * .4,
                      child: CustomTextField(
                        hint: 'E.g: 234',
                        suffix: const Icon(Icons.credit_card,
                            color: Palette.orangeColor),
                        controller: _cvvController,
                      ),
                    ),
                    const CustomSpacer(
                      flex: 3,
                    ),
                    Text(
                      'Amount',
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
                    ),
                    const CustomSpacer(flex: 4),
                    Align(
                      alignment: Alignment.center,
                      child: Button(
                          text: 'Pay',
                          active: buttonActive,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              walletVM.showDialog(
                                  DialogContentType.transactionComplete);
                            }
                          },
                          color: Palette.lightGreen),
                    ),
                    const CustomSpacer(flex: 3),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
