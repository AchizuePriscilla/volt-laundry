import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt/models/order_history_model.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/utils.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  void initState() {
    super.initState();
    context.read<LaundryVM>().getOrderHistory();
  }

  @override
  Widget build(BuildContext context) {
    var laundryVM = context.read<LaundryVM>();
    return ResponsiveWidget(
        appBar: CustomAppBar(
          text: 'History',
        ),
        builder: (_, size) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            height: size.height,
            width: size.width,
            child: FutureBuilder<List<Order>>(
              future: laundryVM.getOrderHistory(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var orders = snapshot.data;
                  return RefreshIndicator(
                    onRefresh: () async {
                      await laundryVM.getOrderHistory();
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 15.w, right: 15.w, bottom: 20.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.w),
                      ),
                      child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          itemCount: orders!.isEmpty ? 1 : orders.length,
                          itemBuilder: (context, index) {
                            return orders.isEmpty
                                ? const EmptyContainer(message: 'Histories')
                                : History(
                                    wearType:
                                        orders[index].userWears[0].wearType,
                                    orderNo: orders[index].orderNo,
                                    netPrice: orders[index]
                                        .netPrice
                                        .amount
                                        .toString(),
                                    serviceType: orders[index].serviceType,
                                    userWears: orders[index].userWears,
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
          );
        });
  }
}

class History extends StatelessWidget {
  final String serviceType;
  final String wearType;
  final String orderNo;
  final String netPrice;
  final List<UserWear> userWears;
  const History({
    required this.serviceType,
    required this.orderNo,
    required this.wearType,
    required this.netPrice,
    required this.userWears,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      height: 32.h,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text(
                serviceType,
                style: GoogleFonts.lato(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.italic),
              ),
              const CustomSpacer(
                flex: 2,
                horizontal: true,
              ),
              Text(
                orderNo,
                style: GoogleFonts.lato(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.italic),
              )
            ]),
            const CustomSpacer(
              flex: 2,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .58,
              height: 10.h,
              child: Row(
                children: [
                  Text(
                    wearType,
                    style: GoogleFonts.lato(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const CustomSpacer(
                    flex: 2,
                    horizontal: true,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        ...userWears[0].wearColor.map(
                              (e) => Container(
                                width: 11.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(e),
                                ),
                              ),
                            ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ]),
          Text(
            "$netPrice VTC",
            style: GoogleFonts.lato(
                fontSize: 17.sp,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryColor),
          )
        ],
      ),
    );
  }
}
