import 'package:flutter/material.dart';
import 'package:volt/presentation/shared/shared.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Drawer(
      child: Container(
        height: size.height,
        color: Palette.buttonColor,
      ),
    );
  }
}
