import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt/models/order_history_model.dart';
import 'package:volt/models/wallet_history_model.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/string_utils.dart';
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

  String getImagePath(bool isVNGN) {
    if (isVNGN) {
      return 'assets/images/volt_naira_coin.png';
    }
    return 'assets/images/volt_coin_yellow.png';
  }

  SelectedCoin selectedCoin = SelectedCoin.voltNaira;
  void _showCoinPickerDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).primaryColorLight,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.w),
            ),
            actions: [
              Container(
                padding: EdgeInsets.only(
                    top: 10.h, bottom: 20.h, left: 20.w, right: 20.w),
                child: Column(
                  children: [
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
                          Radio<SelectedCoin>(
                              value: SelectedCoin.voltCoin,
                              toggleable: true,
                              groupValue: selectedCoin,
                              onChanged: (SelectedCoin? newValue) {
                                setState(() {
                                  isVNGN = false;
                                  selectedCoin = newValue!;
                                });
                                Navigator.pop(context);
                              },
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
                          Radio<SelectedCoin>(
                              value: SelectedCoin.voltNaira,
                              toggleable: true,
                              groupValue: selectedCoin,
                              onChanged: (SelectedCoin? newValue) {
                                setState(() {
                                  isVNGN = true;
                                  selectedCoin = newValue!;
                                });
                                Navigator.pop(context);
                              },
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    context.read<AppProfileVM>().fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    var walletVM = context.read<WalletVM>();
    var laundryVM = context.read<LaundryVM>();
    var rxAppProfileVM = context.watch<AppProfileVM>();
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
                          height: 35.h,
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
                                child: Image.asset(getImagePath(isVNGN)),
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
                                    _showCoinPickerDialog();
                                  }),
                            ],
                          ),
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
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: TabBarView(children: [
                    FutureBuilder<List<History>>(
                      future: walletVM.getWalletHistory(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var history = snapshot.data;
                          return RefreshIndicator(
                            onRefresh: () async {
                              await walletVM.getWalletHistory();
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 25.h),
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.w),
                                color: Palette.lightBlue,
                              ),
                              child: ListView.builder(
                                  itemCount:
                                      history!.isEmpty ? 1 : history.length,
                                  itemBuilder: (context, index) {
                                    return history.isEmpty
                                        ? const EmptyContainer(
                                            message: 'Transaction History')
                                        : AccountHistory(
                                            currency:
                                                history[index].amount.currency,
                                            transactionType:
                                                history[index].transactionType,
                                            amount:
                                                history[index].amount.amount,
                                            description:
                                                history[index].description,
                                          );
                                  }),
                            ),
                          );
                        }
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('Sorry, an error occured, try again'),
                          );
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                    FutureBuilder<List<Order>>(
                      future: laundryVM.getOrderHistory(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var orders = snapshot.data;
                          return RefreshIndicator(
                            onRefresh: () async {
                              await laundryVM.getOrderHistory();
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 25.h),
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.w),
                              ),
                              child: ListView.builder(
                                  itemCount:
                                      orders!.isEmpty ? 1 : orders.length,
                                  itemBuilder: (context, index) {
                                    return orders.isEmpty
                                        ? const EmptyContainer(
                                            message: 'Order History')
                                        : TransactionHistory(
                                            serviceType:
                                                laundryVM.getServiceTypeEnum(
                                                    orders[index].serviceType),
                                                    price: orders[index].netPrice.amount,
                                                    date: StringUtils.getTimeAgo(orders[index].createdAt));
                                  }),
                            ),
                          );
                        }
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('Sorry, an error occured, try again'),
                          );
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
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
                  // loading: rxWalletVM.loading,
                  text: 'Buy ${getCoinType(isVNGN)}',
                  onPressed: () {
                    if (isVNGN) {
                      walletVM.navigateToRoute(checkoutViewRoute);

                      // walletVM.transactionInit(
                      //     email: context.read<AppProfileVM>().email,
                      //     amount: 2000);
                    } else {
                      walletVM.navigateToRoute(fundVTCWalletViewRoute);
                    }
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
  final String currency;
  final String transactionType;
  final String description;
  final double amount;
  const AccountHistory({
    Key? key,
    required this.currency,
    required this.transactionType,
    required this.description,
    required this.amount,
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
            child: Image.asset(currency == 'VLTCOIN'
                ? 'assets/images/volt_coin_yellow.png'
                : 'assets/images/volt_naira_coin.png'),
          ),
          const CustomSpacer(
            flex: 2,
            horizontal: true,
          ),
          Text(
            currency == 'VLTCOIN' ? 'Volt Coin' : 'Volt Naira Coin',
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
                amount.toString(),
                style: GoogleFonts.lato(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: transactionType == 'DEBIT'
                        ? Colors.red
                        : Palette.lightGreen),
              ),
              Text(
                description,
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
