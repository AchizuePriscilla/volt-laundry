import 'package:flutter/material.dart';
import 'package:volt/presentation/shared/shared.dart';

abstract class BottomSheetHandler {
  Future<dynamic> triggerModalBottomSheet(
    context, {
    required Widget child,
    double? height,
    bool isShort = false,
    bool isDismissable = true,
    Color? backgroundColor,
  });
}

class BottomSheetHandlerImpl implements BottomSheetHandler {
  @override
  Future<dynamic> triggerModalBottomSheet(
    context, {
    required Widget child,
    double? height,
    bool isShort = false,
    bool isDismissable = true,
    Color? backgroundColor,
  }) {
    return showModalBottomSheet(
      barrierColor: Theme.of(context).primaryColorLight.withOpacity(.7),
      isScrollControlled: true,
      isDismissible: isDismissable,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.h),
          topRight: Radius.circular(30.h),
        ),
      ),
      backgroundColor: backgroundColor ?? Palette.buttonColor,
      context: context,
      builder: (context) => CustomBottomSheet(
        height: height,
        child: child,
        isShort: isShort,
        backgroundColor: backgroundColor,
      ),
    );
  }
}
