import 'package:flutter/material.dart';
import 'package:volt/presentation/shared/shared.dart';

class CustomBottomSheet extends StatelessWidget {
  final Widget child;
  final bool isShort;
  final Color? backgroundColor;
  final double? height;
  const CustomBottomSheet({
    Key? key,
    required this.child,
    required this.isShort,
    this.backgroundColor,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      constraints: BoxConstraints(
        maxHeight: height ?? (isShort ? 200.h : 250.h),
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? Palette.buttonColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.h),
          topRight: Radius.circular(30.h),
        ),
      ),
      child: child,
    );
  }
}
