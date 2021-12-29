import 'package:flutter/material.dart';
import 'package:volt/models/dialog/dialog_request.dart';
import 'package:volt/presentation/shared/shared.dart';

class TransactionSuccessfulDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(bool) dismissDialog;
  const TransactionSuccessfulDialog({
    Key? key,
    required this.request,
    required this.dismissDialog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTapDown: (details) {
        //do nothing if dialog is not dismissable
        // if (!request.dismissable) return;

        var screenOffset = details.localPosition;
        var dialogCardHeight = dialogContainerKey.currentContext!.size!.height;

        //dismiss dialog if user taps on any screen area outside the dimensions of the dialog

        if (screenOffset.dy < (height - dialogCardHeight) / 2 ||
            screenOffset.dy > (height + dialogCardHeight) / 2) {
          dismissDialog(true);
        }
        if (screenOffset.dx < dialogMargin ||
            screenOffset.dx > (width - dialogMargin)) {
          dismissDialog(true);
        }
      },
      child: Material(
        color: Theme.of(context).primaryColorLight.withOpacity(.75),
        elevation: 10,
        child: SizedBox(
          height: height,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                key: dialogContainerKey,
                constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width * .6,
                    minHeight: MediaQuery.of(context).size.height * .4),
                margin: EdgeInsets.symmetric(horizontal: dialogMargin),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.w),
                  color: Theme.of(context).primaryColorLight,
                ),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      height: 40.h,
                      width: 40.h,
                      decoration: const BoxDecoration(
                        color: Palette.lightGreen,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child:
                            Icon(Icons.check, size: 20.h, color: Colors.white),
                      ),
                    ),
                    const CustomSpacer(
                      flex: 3,
                    ),
                    Text(
                      'You received',
                      style: GoogleFonts.lato(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const CustomSpacer(
                      flex: 1,
                    ),
                    Text(
                      '500',
                      style: GoogleFonts.lato(
                          fontSize: 45.sp,
                          fontWeight: FontWeight.w700,
                          color: Palette.lightGreen),
                    ),
                    const CustomSpacer(
                      flex: 1,
                    ),
                    Text(
                      'Volt coins',
                      style: GoogleFonts.lato(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const CustomSpacer(
                      flex: 3,
                    ),
                    Text(
                      'Your transaction has been initiated. Your balance will be updated after your transaction is processed',
                      style: GoogleFonts.lato(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const CustomSpacer(
                      flex: 3,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Button(
                        onPressed: () => dismissDialog(false),
                        text: request.buttonText,
                        color: Palette.lightGreen,
                        isRounded: true,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
