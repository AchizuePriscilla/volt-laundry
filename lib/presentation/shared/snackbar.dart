import 'package:flutter/material.dart';
import 'package:volt/presentation/shared/shared.dart';

void showSnackbar(
    String title, String message, Color backgroundColor, GlobalKey<ScaffoldMessengerState>? scaffoldKey,
    {int duration = 2}) {
  scaffoldKey!.currentState?.showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor,
      content: SizedBox(
        height: 30.h,
        child: Center(
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              const CustomSpacer(flex: 2,),
              Text(
                message,
                style: TextStyle(fontSize: 14.sp),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
