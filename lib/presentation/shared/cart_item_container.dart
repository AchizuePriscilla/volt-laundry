import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:volt/models/navigation/delivery_details_args.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/utils.dart';

class CartItemContainer extends StatefulWidget {
  final ClothType clothType;
  final VoidCallback? onTap;
  const CartItemContainer({
    Key? key,
    required this.clothType,
    this.onTap,
  }) : super(key: key);

  @override
  _CartItemContainerState createState() => _CartItemContainerState();
}

class _CartItemContainerState extends State<CartItemContainer> {
  String selectedValue = 'Men';
  int _numberOfClothes = 0;

  void _incrementCloth() {
    setState(() {
      _numberOfClothes++;
    });
  }

  void _decrementCloth() {
    setState(() {
      _numberOfClothes == 0 ? null : _numberOfClothes--;
    });
  }

  @override
  Widget build(BuildContext context) {
    var laundryDetailsVM = context.read<LaundryVM>();
    return Slidable(
      endActionPane:
          ActionPane(motion: const ScrollMotion(), extentRatio: .3, children: [
        Container(
            height: 30.h,
            width: 30.h,
            margin: EdgeInsets.only(left: 15.w),
            decoration:
                const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
            child: Icon(Icons.close,
                color: Theme.of(context).primaryColorLight, size: 20.h))
      ]),
      child: InkWell(
        onTap: widget.onTap ??
            () {
              laundryDetailsVM.navigateToRoute(deliveryDetailsViewRoute,
                  DeliveryDetailsArgs(numberOfWears: _numberOfClothes));
            },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10.h),
          constraints: BoxConstraints.tight(Size(
            MediaQuery.of(context).size.width * .9,
            60.h,
          )),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            borderRadius: BorderRadius.circular(30.w),
          ),
          child: Container(
            padding: EdgeInsets.only(left: 15.w, right: 8.w),
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
                          '30 VTC',
                          style: GoogleFonts.roboto(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).primaryColor),
                        ),
                        const CustomSpacer(
                          flex: 2,
                          horizontal: true,
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
                      width: 110.w,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10.w),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              padding: const EdgeInsets.all(0),
                              onPressed: () {
                                _decrementCloth();
                              },
                              icon: Icon(
                                Icons.remove,
                                size: 14.w,
                                color: Theme.of(context).primaryColorLight,
                              ),
                            ),
                            Text(_numberOfClothes.toString(),
                                style: TextStyle(
                                  color: Theme.of(context).primaryColorLight,
                                )),
                            IconButton(
                              padding: const EdgeInsets.all(0),
                              onPressed: () {
                                _incrementCloth();
                              },
                              icon: Icon(
                                Icons.add,
                                size: 14.w,
                                color: Theme.of(context).primaryColorLight,
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 22.h,
                      width: 47.h,
                      // color: Colors.black,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            height: 17.h,
                            width: 13.h,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                          ),
                          Container(
                            height: 17.h,
                            width: 13.h,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.yellow,
                            ),
                          ),
                          Container(
                            height: 17.h,
                            width: 13.h,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
