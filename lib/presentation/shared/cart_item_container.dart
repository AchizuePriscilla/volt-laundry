import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/utils.dart';

class CartItemContainer extends StatefulWidget {
  final ClothType clothType;
  final VoidCallback onTap;
  const CartItemContainer({
    Key? key,
    required this.clothType,
    required this.onTap,
  }) : super(key: key);

  @override
  _CartItemContainerState createState() => _CartItemContainerState();
}

class _CartItemContainerState extends State<CartItemContainer> {
  String selectedValue = 'Men';

  @override
  Widget build(BuildContext context) {
    var laundryDetailsVM = context.read<LaundryVM>();
    return Container(
      // height: 60.h,
      // width: MediaQuery.of(context).size.width * .8,
      margin: EdgeInsets.symmetric(vertical: 10.h),
      constraints: BoxConstraints.tight(Size(
        MediaQuery.of(context).size.width * .8,
        60.h,
      )),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.circular(30.w),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff08141B).withOpacity(.05),
              spreadRadius: 10,
              blurRadius: 7,
              offset: const Offset(0, 15),
            )
          ]),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
                height: 27.h,
                child: Image.asset(
                    'assets/images/${laundryDetailsVM.getImagePath(widget.clothType)}.png')),
            const CustomSpacer(
              flex: 2,
              horizontal: true,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  laundryDetailsVM.getDesc(widget.clothType),
                  textAlign: TextAlign.left,
                  style: GoogleFonts.lato(
                      fontSize: 15.sp, fontWeight: FontWeight.w700),
                ),
                Row(
                  children: [
                    Text(
                      '₦300  ',
                      style: GoogleFonts.roboto(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).primaryColor),
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedValue,
                        isDense: true,
                        onChanged: (String? value) {
                          setState(() {
                            selectedValue = value!;
                          });
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Theme.of(context).disabledColor,
                          // size: 24.w,
                        ),
                        style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).disabledColor),
                        items: [
                          'Men',
                          'Women',
                        ].map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const Expanded(child: SizedBox()),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 22.h,
                  width: 47.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10.w),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.remove,
                          size: 15.w,
                          color: Theme.of(context).primaryColorLight,
                        ),
                        Text('4'),
                        Icon(
                          Icons.add,
                          size: 15.w,
                          color: Theme.of(context).primaryColorLight,
                        ),
                      ]),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
