import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeFields extends StatefulWidget {
  final StreamController<ErrorAnimationType> errorController;
  final TextEditingController controller;
  final Function(String) validator;
  final int length;
  final bool hasError;
  const PinCodeFields({
    Key? key,
    required this.controller,
    required this.validator,
    required this.errorController,
    this.hasError = false,
    this.length = 4,
  }) : super(key: key);

  @override
  _PinCodeFieldsState createState() => _PinCodeFieldsState();
}

class _PinCodeFieldsState extends State<PinCodeFields> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
      child: PinCodeTextField(
        autovalidateMode: AutovalidateMode.disabled,
        appContext: context,
        pastedTextStyle: TextStyle(
          color: Colors.green.shade600,
          fontWeight: FontWeight.bold,
        ),
        length: widget.length,
        animationType: AnimationType.fade,
        validator: (v) {
          return widget.validator(v!);
        },
        pinTheme: PinTheme(
          selectedColor: Theme.of(context).primaryColor.withOpacity(.7),
          selectedFillColor: Theme.of(context).primaryColor.withOpacity(.3),
          inactiveColor: const Color(0xff99A9F2).withOpacity(.4),
          inactiveFillColor: const Color(0xff99A9F2).withOpacity(.1),
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5.h),
          fieldHeight: 40.h,
          fieldWidth: 40.w,
          activeColor: widget.hasError
              ? Theme.of(context).errorColor
              : Theme.of(context).primaryColor.withOpacity(.8),
          activeFillColor: widget.hasError
              ? Theme.of(context).errorColor
              : Theme.of(context).primaryColor.withOpacity(.8),
        ),
        cursorColor: Theme.of(context).primaryColorLight,
        animationDuration: const Duration(milliseconds: 300),
        enableActiveFill: true,
        errorAnimationController: widget.errorController,
        controller: widget.controller,
        keyboardType: TextInputType.number,
        boxShadows: const [
          BoxShadow(
            offset: Offset(0, 1),
            color: Colors.black12,
            blurRadius: 10,
          )
        ],
        onChanged: (value) {},
        beforeTextPaste: (text) {
          return true;
        },
      ),
    );
  }
}