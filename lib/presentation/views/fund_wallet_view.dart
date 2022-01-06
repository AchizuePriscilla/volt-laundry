import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt/models/dialog/dialog_request.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/app_profile_view_model.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/utils.dart';

class FundWalletView extends StatefulWidget {
  const FundWalletView({Key? key}) : super(key: key);

  @override
  State<FundWalletView> createState() => _FundWalletViewState();
}

class _FundWalletViewState extends State<FundWalletView> {
  bool isVNGN = true;

  String getCoinType(bool isVNGN) {
    if (isVNGN) {
      return 'Volt Naira coin';
    }
    return 'Volt Coin';
  }

  @override
  void initState() {
    super.initState();
    context.read<AppProfileVM>().fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    var walletVM = context.read<WalletVM>();
    return ResponsiveWidget(builder: (_, size) {
      return DefaultTabController(
        length: 2,
        child: Stack(
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
                        const CustomSpacer(flex: 2),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: CustomBackButton(
                              color: Theme.of(context).primaryColorLight),
                        ),
                        const CustomSpacer(flex: 1),
                        Container(
                          height: 40.h,
                          width: 125.h,
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
                                getCoinType(isVNGN),
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
                  child: TabBarView(children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 25.h),
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.w),
                        color: Palette.lightBlue,
                      ),
                      child: ListView(children: const [
                        AccountHistory(),
                        AccountHistory(),
                        AccountHistory(),
                        AccountHistory(),
                        AccountHistory(),
                        AccountHistory(),
                      ]),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 25.h),
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: ListView(
                        children: const [
                          TransactionHistory(serviceType: ServiceType.ironing),
                          TransactionHistory(
                              serviceType: ServiceType.washAndIron),
                          TransactionHistory(
                              serviceType: ServiceType.dryCleaning),
                          TransactionHistory(serviceType: ServiceType.ironing),
                          TransactionHistory(serviceType: ServiceType.ironing),
                          TransactionHistory(
                              serviceType: ServiceType.washAndIron),
                          TransactionHistory(
                              serviceType: ServiceType.dryCleaning),
                          TransactionHistory(serviceType: ServiceType.ironing)
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            ),
            Positioned(
              top: size.height * (3 / 10) - 40.h / 2,
              left: 85.w,
              right: 85.w,
              child: Container(
                height: 40.h,
                width: size.width * .4,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.w),
                  color: const Color(0xff92C1D6),
                ),
                child: TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: Palette.buttonColor,
                    unselectedLabelColor: Theme.of(context).primaryColorLight,
                    tabs: [
                      Tab(
                        icon: Icon(
                          Icons.restore,
                          size: 20.h,
                        ),
                      ),
                      Icon(
                        Icons.compare_arrows,
                        size: 20.h,
                      ),
                    ]),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 10.h),
                child: Button(
                  loading: walletVM.loading,
                  text: 'Buy ${getCoinType(isVNGN)}',
                  onPressed: () {
                    walletVM.transactionInit(
                        email: context.read<AppProfileVM>().email,
                        amount: 2000);
                    // walletVM.navigateToRoute(paymentMethodViewRoute);
                  },
                  color: Palette.lightGreen,
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}

class AccountHistory extends StatelessWidget {
  const AccountHistory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        children: [
          SizedBox(
            height: 33.h,
            width: 33.h,
            child: Image.asset('assets/images/volt_coin_yellow.png'),
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
    );
  }
}

class CoinPickerDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(bool) dismissDialog;
  const CoinPickerDialog({
    Key? key,
    required this.request,
    required this.dismissDialog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTapDown: (details) {
        //do nothing if dialog is not dismissable
        if (!request.dismissable) return;

        var screenOffset = details.localPosition;
        var dialogCardHeight = dialogContainerKey.currentContext!.size!.height;

        //dismiss dialog if user taps on any screen area outside the dimensions of the dialog

        if (screenOffset.dy < (height - dialogCardHeight) / 2 ||
            screenOffset.dy > (height + dialogCardHeight) / 2) {
          dismissDialog(true);
        }
        if (screenOffset.dx < dialogMargin ||
            screenOffset.dx > (width - dialogMargin)) {
          dismissDialog(true);
        }
      },
      child: Material(
        color: Theme.of(context).primaryColorLight.withOpacity(.75),
        elevation: 10,
        child: SizedBox(
          height: height,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width * .3,
                    minHeight: MediaQuery.of(context).size.height * .22),
                margin: EdgeInsets.symmetric(horizontal: dialogMargin),
                padding: EdgeInsets.only(
                    top: 10.h, bottom: 20.h, left: 20.w, right: 20.w),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: BorderRadius.circular(30.w),
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            dismissDialog(true);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.red,
                          )),
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
                            flex: 1,
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
                          Radio(
                              value: 1,
                              toggleable: true,
                              groupValue: 1,
                              onChanged: (value) => dismissDialog(false),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap),
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
                                'assets/images/volt_naira_coin.png'),
                          ),
                          const CustomSpacer(
                            flex: 1,
                            horizontal: true,
                          ),
                          Text(
                            'Volt Naira Coin',
                            style: GoogleFonts.lato(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Radio(
                              value: 0,
                              toggleable: true,
                              groupValue: 1,
                              onChanged: (value) => dismissDialog(false),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
