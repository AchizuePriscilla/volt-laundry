import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatarOption extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  const AvatarOption({Key? key, required this.text, required this.icon, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 105.w,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: 10.w, right: 10.w, top: 50.h, bottom: 10.h),
              height: 50.h,
              width: 75.w,
              child: Icon(
                icon,
                color: Theme.of(context).primaryColorLight,
                size: 40.h,
              ),
            ),
            Container(
                margin: EdgeInsets.only(
                  left: 10.w,
                  right: 10.w,
                ),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Theme.of(context).primaryColorLight,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
