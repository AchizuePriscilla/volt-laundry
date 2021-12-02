import 'package:flutter/material.dart';
import 'package:volt/handlers/handlers.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/utils/utils.dart';

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
              onPressed: () {
                locator<NavigationHandler>().pushNamed(pickupDetailsViewRoute);
              },
              color: Palette.lightGreen,
            ),
          ),
        ],
      ),
    );
  }
}
