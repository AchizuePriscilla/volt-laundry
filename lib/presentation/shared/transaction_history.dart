import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/theme/palette.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/utils.dart';

class TransactionHistory extends StatelessWidget {
  final ServiceType serviceType;
  const TransactionHistory({Key? key, required this.serviceType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var laundryVM = context.read<LaundryVM>();
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 35.h,
            width: 35.h,
            child: Image.asset(
              laundryVM.getServiceImagePath(serviceType),
            ),
          ),
          const CustomSpacer(
            flex: 4,
            horizontal: true,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                laundryVM.getServiceDesc(serviceType),
                style: GoogleFonts.lato(
                    fontWeight: FontWeight.w600,
                    fontSize: 17.sp,
                    color: const Color(0xff0083FF)),
              ),
              const CustomSpacer(
                flex: 1,
              ),
              Text(
                'yesterday',
                style: GoogleFonts.lato(
                    fontWeight: FontWeight.w300,
                    fontSize: 13.sp,
                    color: Theme.of(context).primaryColor),
              ),
            ],
          ),
          const Expanded(child: SizedBox()),
          Text(
            '₦6,000',
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w300,
                fontSize: 13.sp,
                color: Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }
}
