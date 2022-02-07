import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:volt/presentation/shared/shared.dart';

class ProfileAvatar extends StatelessWidget {
  final bool isSmall;
  final Function()? onPressed;
  final bool canEdit;
  final String profilePicPath;
  const ProfileAvatar(
      {Key? key,
      this.onPressed,
      this.isSmall = false,
      this.canEdit = true,
      required this.profilePicPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Stack(
        children: [
          _ImageContainer(
            isSmall: isSmall,
            profilePicPath: profilePicPath,
          ),
          if (canEdit)
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
    );
  }
}

class _ImageContainer extends StatelessWidget {
  final bool isSmall;
  final String profilePicPath;
  const _ImageContainer(
      {Key? key, this.isSmall = false, required this.profilePicPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (profilePicPath.isNotEmpty &&
        profilePicPath.startsWith("http") &&
        profilePicPath != "undefined") {
      return CachedNetworkImage(
        imageUrl: profilePicPath,
        placeholder: (_, __) {
          return Container(
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
          );
        },
        imageBuilder: (_, imageProvider) {
          return Container(
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
                  image: Image.network(
                    profilePicPath,
                    fit: BoxFit.cover,
                  ).image,
                ),
              ),
            ),
          );
        },
        errorWidget: (_, __, ___) {
          return Container(
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
          );
        },
      );
    } else {
      return CircleAvatar(
        radius: isSmall ? 65.w : 88.w,
        backgroundColor: Theme.of(context).backgroundColor,
        backgroundImage: Image.asset(
          'assets/images/empty_profile_picture.png',
          fit: BoxFit.cover,
        ).image,
      );
    }
  }
}
