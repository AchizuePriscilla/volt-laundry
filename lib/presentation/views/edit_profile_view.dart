import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt/handlers/bottom_sheet_handler.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/locator.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var profileVM = context.read<AppProfileVM>();
    return ResponsiveWidget(
        resizeToAvoidBottomInset: true,
        builder: (_, size) {
          return Container(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: SizedBox(
                height: size.height,
                child: ListView(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: CustomBackButton(color: Palette.blackColor),
                    ),
                    const CustomSpacer(
                      flex: 3,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ProfileAvatar(
                        profilePicPath: context.watch<AppProfileVM>().profilePic,
                          canEdit: true,
                          isSmall: true,
                          onPressed: () {
                            locator<BottomSheetHandler>()
                                .triggerModalBottomSheet(context,
                                    child: Row(
                                      children: [
                                        AvatarOption(
                                          text: 'Camera',
                                          icon: Icons.photo_camera,
                                          onTap: () {},
                                        ),
                                        AvatarOption(
                                          text: 'Gallery',
                                          icon: Icons.image,
                                          onTap: () {},
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
                      controller: nameController..text = profileVM.name,
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
                      controller: phoneNumberController
                        ..text = profileVM.number,
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
                      controller: addressController..text = profileVM.address,
                    ),
                    // const CustomSpacer(flex: 3),
                    // Text(
                    //   'State',
                    //   style: GoogleFonts.lato(
                    //     fontSize: 18.sp,
                    //     fontWeight: FontWeight.w600,
                    //     color: Theme.of(context).disabledColor.withOpacity(.7),
                    //   ),
                    // ),
                    // const CustomSpacer(flex: 1),
                    // CustomTextField(
                    //   fillColor:
                    //       Theme.of(context).disabledColor.withOpacity(.1),
                    //   hint: 'E.g: Enugu',
                    // ),
                    const CustomSpacer(flex: 6),
                    Align(
                      alignment: Alignment.center,
                      child: Button(
                        text: 'Save',
                        color: Palette.lightGreen,
                        loading: context.watch<AppProfileVM>().loading,
                        onPressed: () {
                          // profileVM.editUser(
                          //   name: nameController.text,
                          //   phoneNumber: phoneNumberController.text,
                          //   address: addressController.text,
                          //   latitude: int.parse(profileVM.latitude.toString()),
                          //   longitude:
                          //       int.parse(profileVM.longitude.toString()),
                          // );
                        },
                      ),
                    ),
                    const CustomSpacer(flex: 5),
                  ],
                ),
              ));
        });
  }
}
