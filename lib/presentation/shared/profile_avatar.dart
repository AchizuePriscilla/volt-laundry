import 'package:flutter/material.dart';
import 'package:volt/presentation/shared/shared.dart';

class ProfileAvatar extends StatelessWidget {
  final bool isSmall;

  final String? profilePicPath;
  final Function? onPressed;
  final bool canEdit;
  const ProfileAvatar({
    Key? key,
    this.onPressed,
    this.isSmall = false,
    this.profilePicPath,
    this.canEdit = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: isSmall ? 145.w : 170.w,
          width: isSmall ? 145.w : 170.w,
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
                image: Image.asset(
                  profilePicPath ?? 'assets/images/me.jpg',
                  fit: BoxFit.cover,
                ).image,
              ),
            ),
          ),
        ),
        if (canEdit)
          Positioned(
            right: 2.w,
            bottom: 100.w,
            child: GestureDetector(
              child: Container(
                height: 34.w,
                width: 34.w,
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
            ),
          )
      ],
    );
  }
}
