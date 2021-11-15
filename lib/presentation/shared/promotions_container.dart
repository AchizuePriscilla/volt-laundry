import 'package:flutter/material.dart';
import 'package:volt/presentation/shared/shared.dart';

class PromotionsContainer extends StatelessWidget {
  final String imagePath;
  const PromotionsContainer({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      width: 230.h,
      margin: EdgeInsets.all(10.h),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.circular(35.w),
          image: DecorationImage(
              image: AssetImage('assets/images/$imagePath.png'),
              fit: BoxFit.cover)),
    );
  }
}
