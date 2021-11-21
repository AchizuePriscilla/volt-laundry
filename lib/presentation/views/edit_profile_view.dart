import 'package:flutter/material.dart';
import 'package:volt/presentation/shared/shared.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(builder: (_, size) {
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomSpacer(
                flex: 20,
              ),
              Align(
                  alignment: Alignment.center,
                  child: ProfileAvatar(
                    canEdit: true,
                    isSmall: true,
                  )),
            ],
          ));
    });
  }
}
