import 'package:flutter/material.dart';
import 'package:volt/handlers/bottom_sheet_handler.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/utils/locator.dart';

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
                    Align(
                      alignment: Alignment.center,
                      child: ProfileAvatar(
                          canEdit: true,
                          isSmall: true,
                          onPressed: () {
                            locator<BottomSheetHandler>()
                                .triggerModalBottomSheet(context,
                                    child: Row(
                                      children: const [
                                        AvatarOption(
                                          text: 'Camera',
                                          icon: Icons.photo_camera,
                                        ),
                                        AvatarOption(
                                          text: 'Gallery',
                                          icon: Icons.image,
                                        )
                                      ],
                                    ),
                                    isShort: true);
                          }),
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

class AvatarOption extends StatelessWidget {
  final String text;
  final IconData icon;
  const AvatarOption({Key? key, required this.text, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 105.w,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                left: 10.w, right: 10.w, top: 50.h, bottom: 10.h),
            height: 50.h,
            width: 75.w,
            child: Icon(
              icon,
              color: Theme.of(context).primaryColorLight,
              size: 40.h,
            ),
          ),
          Container(
              margin: EdgeInsets.only(
                left: 10.w,
                right: 10.w,
              ),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Theme.of(context).primaryColorLight,
                ),
              ))
        ],
      ),
    );
  }
}
