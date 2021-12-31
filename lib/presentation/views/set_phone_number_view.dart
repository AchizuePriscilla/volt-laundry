import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/utils.dart';

class SetPhoneNumberView extends StatefulWidget {
  const SetPhoneNumberView({Key? key}) : super(key: key);

  @override
  State<SetPhoneNumberView> createState() => _SetPhoneNumberViewState();
}

class _SetPhoneNumberViewState extends State<SetPhoneNumberView> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var verificationVM = context.read<VerificationViewModel>();
    return ResponsiveWidget(builder: (_, size) {
      return SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomSpacer(
                  flex: 22,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 60.h,
                    width: 50.w,
                    child: Image.asset('assets/images/volt_phone.png'),
                  ),
                ),
                const CustomSpacer(
                  flex: 10,
                ),
                Text(
                  'Set Your Phone Number',
                  style: GoogleFonts.lato(
                      fontSize: 21.sp, fontWeight: FontWeight.w500),
                ),
                const CustomSpacer(
                  flex: 2,
                ),
                Text(
                  'Please enter your phone number to verify your account',
                  style: GoogleFonts.lato(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).disabledColor),
                ),
                const CustomSpacer(
                  flex: 3,
                ),
                TextFormField(
                  cursorColor: Theme.of(context).primaryColor,
                  validator: (phoneNumber) {
                    return verificationVM.validatePhoneNumber(phoneNumber!);
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                        borderSide: BorderSide(
                          color:
                              Theme.of(context).primaryColor.withOpacity(.06),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              Theme.of(context).primaryColor.withOpacity(.06),
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      hintText: 'e.g: +2348145518998',
                      hintStyle: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color:
                              Theme.of(context).disabledColor.withOpacity(.5)),
                      filled: true,
                      fillColor:
                          Theme.of(context).primaryColor.withOpacity(.06),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 10.h),
                      prefixIcon: const Icon(Icons.phone)
                      // CountryCodePicker(
                      //   initialSelection: 'ng',
                      //   showCountryOnly: true,
                      //   showDropDownButton: true,
                      //   hideMainText: true,
                      //   showFlagMain: true,
                      //   flagWidth: 28,
                      //   padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                      // ),
                      ),
                ),
                const CustomSpacer(
                  flex: 3,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Button(
                    // active: _formKey.currentState!.validate(),
                    text: 'Next',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        verificationVM.navigateToRoute(verificationViewRoute);
                      }
                    },
                    isSmall: true,
                  ),
                ),
                const CustomSpacer(
                  flex: 3,
                ),
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text:
                            'By providing my phone number, I agree and accept the ',
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).disabledColor),
                        children: [
                          TextSpan(
                            text: 'Terms of service ',
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).primaryColor),
                          ),
                          const TextSpan(text: 'and '),
                          TextSpan(
                            text: 'Privacy policy',
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).primaryColor),
                          )
                        ]),
                  ),
                ),
                const CustomSpacer(
                  flex: 3,
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
