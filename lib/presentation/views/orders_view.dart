import 'package:flutter/material.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/views/views.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({Key? key}) : super(key: key);

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        scaffoldKey: scaffoldKey,
        drawer: SizedBox(
            width: MediaQuery.of(context).size.width * .92,
            child: const DriverDrawer()),
        builder: (context, size) {
          return Column(
            children: [
              const CustomSpacer(flex: 7),
              Padding(
                padding: EdgeInsets.only(left: 25.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        scaffoldKey.currentState!.openDrawer();
                      },
                      child: ImageIcon(
                        const AssetImage('assets/images/hamburger.png'),
                        color: Colors.black,
                        size: 20.h,
                      ),
                    ),
                    Text(
                      'Orders',
                      style: GoogleFonts.lato(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 25.w),
                      child: IconButton(
                        icon: Icon(
                          Icons.shopping_cart_outlined,
                          size: 20.h,
                          color: const Color(0xff000000).withOpacity(.25),
                        ),
                        onPressed: () {
                          // homeVM.navigateToCartView();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                color: Theme.of(context).disabledColor.withOpacity(.46),
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(20),
                  right: Radius.circular(20),
                ),
              )))
            ],
          );
        });
  }
}
