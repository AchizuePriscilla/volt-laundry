import 'package:flutter/material.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/utils/utils.dart';

class WalletView extends StatelessWidget {
  const WalletView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (_, size) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            children: [
              const CustomSpacer(
                flex: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 60.h,
                    width: 85.h,
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
                  Container(
                    height: 60.h,
                    width: 85.h,
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
                      TransactionHistory(serviceType: ServiceType.ironing),
                      TransactionHistory(serviceType: ServiceType.washAndIron),
                      TransactionHistory(serviceType: ServiceType.dryCleaning),
                      TransactionHistory(serviceType: ServiceType.ironing),
                      TransactionHistory(serviceType: ServiceType.ironing),
                      TransactionHistory(serviceType: ServiceType.washAndIron),
                      TransactionHistory(serviceType: ServiceType.dryCleaning),
                      TransactionHistory(serviceType: ServiceType.ironing)
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
