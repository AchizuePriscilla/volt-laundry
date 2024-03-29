import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';

class VerificationView extends StatefulWidget {
  const VerificationView({Key? key}) : super(key: key);

  @override
  _VerificationViewState createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  final TextEditingController _controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  // ignore: close_sinks
  StreamController<ErrorAnimationType>? _errorController;
  final bool _hasError = false;
  bool buttonActive = false;

  void onListen() {
    if (_controller.text.length < 4) {
      setState(() {
        buttonActive = false;
      });
    } else {
      setState(() {
        buttonActive = true;
      });
    }
  }

  @override
  void initState() {
    _errorController = StreamController<ErrorAnimationType>();
    var verificationVM = context.read<VerificationViewModel>();
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        verificationVM.startTimer();
      },
    );

    _controller.addListener(onListen);
  }

  @override
  void dispose() {
    _errorController!.close();
    // _controller.removeListener(onListen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var verificationVM = context.read<VerificationViewModel>();
    return ResponsiveWidget(
      builder: (_, size) {
        return Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Container(
              height: size.height,
              width: size.width,
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Column(
                children: [
                  const CustomSpacer(flex: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomBackButton(
                      color: Palette.blackColor,
                      onTap: () {
                        verificationVM.onPop();
                      },
                    ),
                  ),
                  const CustomSpacer(flex: 20),
                  Text(
                    context.watch<VerificationViewModel>().getTime,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Palette.buttonColor,
                      fontSize: 36.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const CustomSpacer(flex: 3),
                  Text(
                    "Enter the verification code \nwe've sent to your phone number",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).disabledColor),
                  ),
                  const CustomSpacer(flex: 3),
                  PinCodeFields(
                      hasError: _hasError,
                      errorController: _errorController!,
                      controller: _controller,
                      validator: (val) {
                        if (val.length < 4) {
                          return 'Enter code';
                        }
                        return null;
                      }),
                  const CustomSpacer(flex: 3),
                  GestureDetector(
                    onTap: () {
                      verificationVM.resendToken(
                          context.read<SignUpViewModel>().phoneNumber);
                    },
                    child: verificationVM.isResendingToken
                        ? Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(
                                Theme.of(context).primaryColor,
                              ),
                            ),
                          )
                        : Text(
                            "Resend Code",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: verificationVM.active
                                  ? Theme.of(context)
                                      .disabledColor
                                      .withOpacity(.7)
                                  : Theme.of(context).primaryColor,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                  ),
                  const CustomSpacer(flex: 3),
                  Button(
                    active: buttonActive,
                    loading: context.watch<SignUpViewModel>().loading,
                    text: 'Next',
                    onPressed: () {
                      context
                          .read<SignUpViewModel>()
                          .verifyCode(_controller.text);
                    },
                    isSmall: true,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
