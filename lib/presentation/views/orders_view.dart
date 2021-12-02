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
        resizeToAvoidBottomInset: false,
        scaffoldKey: scaffoldKey,
        drawer: SizedBox(
            width: MediaQuery.of(context).size.width * .92,
            child: const DriverDrawer()),
        builder: (context, size) {
          return Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
              image: const DecorationImage(
                image: AssetImage('assets/images/white_background.png'),
              ),
            ),
            child: Column(
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
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).disabledColor.withOpacity(.46),
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(20),
                        right: Radius.circular(20),
                      ),
                    ),
                    child: ListView.builder(
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 20.w),
                              child: const OrderCard());
                        }),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class OrderCard extends StatelessWidget {
  const OrderCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 140.h,
      width: size.width * .8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).primaryColorLight),
      child: Column(
        children: [
          const CustomSpacer(flex: 3),
          Text(
            'Order Number',
            style:
                GoogleFonts.lato(fontWeight: FontWeight.w300, fontSize: 14.sp),
          ),
          const CustomSpacer(flex: 1),
          Text(
            'QK78',
            style:
                GoogleFonts.lato(fontWeight: FontWeight.w700, fontSize: 36.sp),
          ),
          const CustomSpacer(flex: 1),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.watch_later, size: 18),
            const CustomSpacer(
              flex: 1,
              horizontal: true,
            ),
            Text(
              '28 Minutes ago',
              style: GoogleFonts.lato(
                  fontWeight: FontWeight.w300, fontSize: 12.sp),
            )
          ]),
          const CustomSpacer(flex: 2),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Button(
              text: 'View Order',
              onPressed: () {},
              color: Palette.lightGreen,
            ),
          ),
        ],
      ),
    );
  }
}
