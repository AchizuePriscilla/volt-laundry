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
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    context.read<AppProfileVM>().downloadUrl = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var profileVM = context.read<AppProfileVM>();
    var rxprofileVM = context.watch<AppProfileVM>();
    var signUpVM = context.read<SignUpViewModel>();
    return ResponsiveWidget(
        resizeToAvoidBottomInset: true,
        builder: (_, size) {
          return Container(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: SizedBox(
                height: size.height,
                child: Form(
                  key: _formKey,
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
                            profilePicPath: rxprofileVM.downloadUrl.isEmpty
                                ? rxprofileVM.profilePic
                                : rxprofileVM.downloadUrl,
                            canEdit: true,
                            onPressed: () {
                              locator<BottomSheetHandler>()
                                  .triggerModalBottomSheet(context,
                                      child: Row(
                                        children: [
                                          AvatarOption(
                                            text: 'Camera',
                                            icon: Icons.photo_camera,
                                            onTap: () {
                                              profileVM.pickImage(
                                                  isCamera: true);
                                            },
                                          ),
                                          AvatarOption(
                                            text: 'Gallery',
                                            icon: Icons.image,
                                            onTap: () {
                                              profileVM.pickImage();
                                            },
                                          )
                                        ],
                                      ),
                                      isShort: true);
                            }),
                      ),
                      const CustomSpacer(flex: 3),
                      Visibility(
                          visible: rxprofileVM.isProfilePhotoUploading,
                          child: const SizedBox(
                            width: 50,
                            height: 50,
                            child: Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Palette.buttonColor),
                              ),
                            ),
                          )),
                      const CustomSpacer(flex: 3),
                      Text(
                        'Name',
                        style: GoogleFonts.lato(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color:
                              Theme.of(context).disabledColor.withOpacity(.7),
                        ),
                      ),
                      const CustomSpacer(flex: 1),
                      CustomTextField(
                        validator: (name) {
                          return signUpVM.validateFullName(name);
                        },
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
                          color:
                              Theme.of(context).disabledColor.withOpacity(.7),
                        ),
                      ),
                      const CustomSpacer(flex: 1),
                      CustomTextField(
                        validator: (phoneNumber) {
                          return signUpVM.validatePhoneNumber(phoneNumber);
                        },
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
                          color:
                              Theme.of(context).disabledColor.withOpacity(.7),
                        ),
                      ),
                      const CustomSpacer(flex: 1),
                      CustomTextField(
                        validator: (address) {
                          return signUpVM.validateText(address);
                        },
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
                            loading: rxprofileVM.loading,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await profileVM.editUser(
                                    name: nameController.text,
                                    phoneNumber: phoneNumberController.text,
                                    address: addressController.text,
                                    latitude: profileVM.latitude!,
                                    longitude: profileVM.longitude!);
                              }
                            }),
                      ),
                      const CustomSpacer(flex: 5),
                    ],
                  ),
                ),
              ));
        });
  }
}
