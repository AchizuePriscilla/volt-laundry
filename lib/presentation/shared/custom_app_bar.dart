import 'package:flutter/material.dart';
import 'package:volt/handlers/handlers.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/utils/utils.dart';

class CustomAppBar extends AppBar {
   final String text;
  final bool automaticallyLead;

  CustomAppBar({
    Key? key,
    this.text = "",
    this.automaticallyLead = true,
  }) : super(
          key: key,
          leading: automaticallyLead ?  const CustomBackButton(): null,
          automaticallyImplyLeading: automaticallyLead,
          title: Text(
            text,
            style: GoogleFonts.lato(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Palette.blackColor),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          toolbarHeight: 70.h,
        );
}