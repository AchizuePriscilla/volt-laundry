import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt/handlers/bottom_sheet_handler.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/app_profile_view_model.dart';
import 'package:volt/presentation/viewmodels/sign_up_view_model.dart';
import 'package:volt/utils/utils.dart';

class SetProfilePictureView extends StatefulWidget {
  const SetProfilePictureView({Key? key}) : super(key: key);

  @override
  _SetProfilePictureViewState createState() => _SetProfilePictureViewState();
}

class _SetProfilePictureViewState extends State<SetProfilePictureView> {
  @override
  void initState() {
    // _showBottomSheet();
    super.initState();
  }

  void _showBottomSheet() {
    var profileVM = context.watch<SignUpViewModel>();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await locator<BottomSheetHandler>().triggerModalBottomSheet(context,
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
                onTap: () {
                  profileVM.pickImage();
                },
              )
            ],
          ),
          isShort: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    var signUp = context.read<SignUpViewModel>();
    var rxSignUpVM = context.watch<SignUpViewModel>();
    log(rxSignUpVM.loading.toString());
    return ResponsiveWidget(builder: (context, size) {
      return Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          image: const DecorationImage(
            image: AssetImage('assets/images/white_background.png'),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Set Your Profile Picture',
              style: GoogleFonts.lato(
                  fontSize: 21.sp, fontWeight: FontWeight.w500),
            ),
            const CustomSpacer(
              flex: 2,
            ),
            ProfileAvatar(
                profilePicPath: signUp.setImage,
                canEdit: true,
                onPressed: () {
                  locator<BottomSheetHandler>().triggerModalBottomSheet(context,
                      child: Row(
                        children: [
                          AvatarOption(
                            text: 'Camera',
                            icon: Icons.photo_camera,
                            onTap: () {
                              signUp.pickImage(isCamera: true);
                            },
                          ),
                          AvatarOption(
                            text: 'Gallery',
                            icon: Icons.image,
                            onTap: () {
                              signUp.pickImage();
                            },
                          )
                        ],
                      ),
                      isShort: true);
                }),
            const CustomSpacer(
              flex: 3,
            ),
            Visibility(
                visible: rxSignUpVM.loading,
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Palette.buttonColor),
                )),
            const CustomSpacer(
              flex: 2,
            ),
            Button(
                text: 'Done',
                active: !rxSignUpVM.loading,
                onPressed: () async {
                  await context.read<SignUpViewModel>().signUp();
                })
          ],
        ),
      );
    });
  }
}
