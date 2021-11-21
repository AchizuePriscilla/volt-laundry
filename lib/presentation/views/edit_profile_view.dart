import 'package:flutter/material.dart';
import 'package:volt/presentation/shared/shared.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        resizeToAvoidBottomInset: true,
        builder: (_, size) {
          return Container(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: SizedBox(
                height: size.height,
                child: ListView(
                  children: [
                    const CustomSpacer(
                      flex: 12,
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: ProfileAvatar(
                        canEdit: true,
                        isSmall: true,
                      ),
                    ),
                    const CustomSpacer(flex: 3),
                    Text(
                      'Name',
                      style: GoogleFonts.lato(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).disabledColor.withOpacity(.7),
                      ),
                    ),
                    const CustomSpacer(flex: 1),
                    CustomTextField(
                      fillColor:
                          Theme.of(context).disabledColor.withOpacity(.1),
                      hint: 'E.g: Ade John',
                    ),
                    const CustomSpacer(flex: 3),
                    Text(
                      'Phone Number',
                      style: GoogleFonts.lato(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).disabledColor.withOpacity(.7),
                      ),
                    ),
                    const CustomSpacer(flex: 1),
                    CustomTextField(
                      fillColor:
                          Theme.of(context).disabledColor.withOpacity(.1),
                      hint: 'E.g: 08145518998',
                    ),
                    const CustomSpacer(flex: 3),
                    Text(
                      'Address',
                      style: GoogleFonts.lato(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).disabledColor.withOpacity(.7),
                      ),
                    ),
                    const CustomSpacer(flex: 1),
                    CustomTextField(
                      fillColor:
                          Theme.of(context).disabledColor.withOpacity(.1),
                      hint: 'E.g: Premiere estate, ugwuaji enugu nigeria',
                    ),
                    const CustomSpacer(flex: 3),
                    Text(
                      'State',
                      style: GoogleFonts.lato(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).disabledColor.withOpacity(.7),
                      ),
                    ),
                    const CustomSpacer(flex: 1),
                    CustomTextField(
                      fillColor:
                          Theme.of(context).disabledColor.withOpacity(.1),
                      hint: 'E.g: Enugu',
                    ),
                    const CustomSpacer(flex: 8),
                    Align(
                        alignment: Alignment.center,
                        child: Button(
                            text: 'Save',
                            color: Palette.lightGreen,
                            onPressed: () {})),
                    const CustomSpacer(flex: 3),
                  ],
                ),
              ));
        });
  }
}
