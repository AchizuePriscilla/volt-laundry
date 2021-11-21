import 'package:flutter/material.dart';
import 'package:volt/presentation/shared/shared.dart';

class HomeMenuContainer extends StatelessWidget {
  final String label;
  final String imagePath;
  final VoidCallback onTap;
  const HomeMenuContainer({
    Key? key,
    required this.label,
    required this.imagePath,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          height: 160.h,
          width: 130.h,
          margin: EdgeInsets.all(10.h),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
              borderRadius: BorderRadius.circular(35.w),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xff393939).withOpacity(.1),
                  spreadRadius: 8,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                )
              ]),
          child: Stack(
            children: [
              Center(
                child: Container(
                  height: 110.h,
                  width: 100.h,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      borderRadius: BorderRadius.circular(35.w),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff08141B).withOpacity(.05),
                          spreadRadius: 10,
                          blurRadius: 7,
                          offset: const Offset(0, 27),
                        )
                      ]),
                  child: Center(
                    child: SizedBox(
                        height: 70.h,
                        width: 70.h,
                        child: Image.asset('assets/images/$imagePath.png')),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      label,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                          fontSize: 14.sp, fontWeight: FontWeight.w600),
                    ),
                    const CustomSpacer(flex: 2),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
