import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt/handlers/bottom_sheet_handler.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/sign_up_view_model.dart';
import 'package:volt/utils/utils.dart';

class SetProfilePictureView extends StatefulWidget {
  const SetProfilePictureView({Key? key}) : super(key: key);

  @override
  _SetProfilePictureViewState createState() => _SetProfilePictureViewState();
}

class _SetProfilePictureViewState extends State<SetProfilePictureView> {

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
            InkWell(
              onTap: () {
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
              },
              child: Stack(
                children: [
                  Container(
                    height: 170.w,
                    width: 170.w,
                    padding: EdgeInsets.all(7.w),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff393939).withOpacity(.4),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        color: Theme.of(context).primaryColorLight,
                        shape: BoxShape.circle),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Palette.buttonColor.withOpacity(.7),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: rxSignUpVM.setImage.isEmpty
                              ? Image.asset(
                                  'assets/images/empty_profile_picture.png',
                                  fit: BoxFit.cover,
                                ).image
                              : Image.network(rxSignUpVM.downloadUrl).image,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 2.w,
                    bottom: 114.w,
                    child: Container(
                      height: 38.w,
                      width: 38.w,
                      padding: EdgeInsets.all(3.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColorLight,
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Palette.lightGreen,
                        ),
                        child: Icon(
                          Icons.camera_alt_outlined,
                          size: 19.w,
                          color: Theme.of(context).primaryColorLight,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const CustomSpacer(
              flex: 3,
            ),
            Visibility(
                visible: rxSignUpVM.isProfilePhotoUploading,
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Palette.buttonColor),
                )),
            const CustomSpacer(
              flex: 2,
            ),
            Button(
                text: 'Done',
                active: !rxSignUpVM.isProfilePhotoUploading &&
                    rxSignUpVM.setImage.isNotEmpty,
                loading: rxSignUpVM.loading,
                onPressed: () async {
                  await context.read<SignUpViewModel>().signUp();
                })
          ],
        ),
      );
    });
  }
}
