
import 'package:flutter/material.dart';
import 'package:volt/presentation/shared/shared.dart';

class CreditCard extends StatelessWidget {
  const CreditCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 130.h,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: const Color(0xff0083FF).withOpacity(.8),
            borderRadius: BorderRadius.all(
              Radius.circular(10.w),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            height: 130.h,
            width: MediaQuery.of(context).size.width * .6,
            decoration: BoxDecoration(
              color: const Color(0xff8CA6DB).withOpacity(.6),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(110.w),
                bottomLeft: Radius.circular(110.w),
                topRight: Radius.circular(10.w),
                bottomRight: Radius.circular(10.w),
              ),
            ),
          ),
        ),
        Container(
          padding:
              EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          height: 130.h,
          width: MediaQuery.of(context).size.width,
          color: Colors.transparent,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                    height: 20.h,
                    width: 50.h,
                    child:
                        Image.asset('assets/images/mastercard.png')),
              ),
              const CustomSpacer(flex: 2),
              Expanded(
                child: Text(
                  'xxxx  xxxx  xxxx  xxxx',
                  style: GoogleFonts.lato(
                      color: Theme.of(context).primaryColorLight,
                      fontWeight: FontWeight.w400,
                      fontSize: 25.sp),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ade John',
                    style: GoogleFonts.lato(
                        color: Theme.of(context).primaryColorLight,
                        fontWeight: FontWeight.w400,
                        fontSize: 20.sp),
                  ),
                  Text(
                    '11/23',
                    style: GoogleFonts.lato(
                        color: Theme.of(context).primaryColorLight,
                        fontWeight: FontWeight.w400,
                        fontSize: 20.sp),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
