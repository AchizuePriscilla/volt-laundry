import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:volt/presentation/shared/shared.dart';

class LaundryOptionsContainer extends StatelessWidget {
  final String label;
  final String imagePath;
  final VoidCallback onTap;
  const LaundryOptionsContainer({
    Key? key,
    required this.label,
    required this.onTap,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // height: 60.h,
        // width: MediaQuery.of(context).size.width * .8,
        margin: EdgeInsets.symmetric(vertical: 10.h),
        constraints: BoxConstraints.tight(Size(
          MediaQuery.of(context).size.width * .8,
          60.h,
        )),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            borderRadius: BorderRadius.circular(30.w),
            boxShadow: [
              BoxShadow(
                color: const Color(0xff08141B).withOpacity(.05),
                spreadRadius: 10,
                blurRadius: 7,
                offset: const Offset(0, 15),
              )
            ]),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                  height: 27.h,
                  child: Image.asset('assets/images/$imagePath.png')),
              Expanded(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      fontSize: 24.sp, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
