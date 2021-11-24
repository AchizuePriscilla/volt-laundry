import 'package:flutter/material.dart';
import 'package:volt/handlers/handlers.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/utils/utils.dart';

class CustomBackButton extends StatelessWidget {
  final Function? onTap;
  final Color? color;
  const CustomBackButton({Key? key, this.onTap, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackButton(
      color: color ?? Palette.blackColor,
      onPressed: () {
        if (onTap == null) {
          locator<NavigationHandler>().goBack();
        } else {
          onTap!();
        }
      },
    );
  }
}
