import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:volt/models/navigation/delivery_details_args.dart';
import 'package:volt/models/process_order_model.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/utils.dart';

class CartItemContainer extends StatefulWidget {
  final UserWear userWear;
  final ClothType clothType;
  final VoidCallback? onDelete;
  final int singleOrderIndex;
  const CartItemContainer(
      {Key? key,
      required this.userWear,
      required this.clothType,
      this.onDelete,
      required this.singleOrderIndex})
      : super(key: key);

  @override
  _CartItemContainerState createState() => _CartItemContainerState();
}

class _CartItemContainerState extends State<CartItemContainer> {
  String selectedValue = 'Men';
  int _numberOfClothes = 0;

  @override
  void initState() {
    super.initState();
    _numberOfClothes = widget.userWear.wearTotal;
  }

  @override
  Widget build(BuildContext context) {
    var cartVM = context.watch<CartVM>();
    return Slidable(
      key: Key(widget.userWear.wearType),
      endActionPane:
          ActionPane(motion: const ScrollMotion(), extentRatio: .3, children: [
        InkWell(
          onTap: widget.onDelete ?? widget.onDelete,
          child: Container(
              height: 30.h,
              width: 30.h,
              margin: EdgeInsets.only(left: 15.w),
              decoration: const BoxDecoration(
                  color: Colors.red, shape: BoxShape.circle),
              child: cartVM.loading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Icon(Icons.close,
                      color: Theme.of(context).primaryColorLight, size: 20.h)),
        )
      ]),
      child: InkWell(
        onTap: () {
          cartVM.navigateToRoute(
              deliveryDetailsViewRoute,
              DeliveryDetailsArgs(
                  numberOfWears: widget.userWear.wearTotal,
                  isCartOrder: true,
                  isSingleCartOrder: true,
                  singleOrderIndex: widget.singleOrderIndex));
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
            padding: EdgeInsets.only(left: 15.w, right: 15.w),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height: 27.h,
                    child: Image.asset(
                        'assets/images/${cartVM.getImagePath(widget.clothType)}.png')),
                const CustomSpacer(
                  flex: 2,
                  horizontal: true,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.userWear.wearType,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.lato(
                          fontSize: 15.sp, fontWeight: FontWeight.w700),
                    ),
                    Row(
                      children: [
                        Text(
                          widget.userWear.price.amount.toString() + ' VTC',
                          style: GoogleFonts.roboto(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).primaryColor),
                        ),
                        // const CustomSpacer(
                        //   flex: 2,
                        //   horizontal: true,
                        // ),
                        // DropdownButtonHideUnderline(
                        //   child: DropdownButton<String>(
                        //     value: selectedValue,
                        //     isDense: true,
                        //     onChanged: (String? value) {
                        //       setState(() {
                        //         selectedValue = value!;
                        //       });
                        //     },
                        //     icon: Icon(
                        //       Icons.keyboard_arrow_down,
                        //       color: Theme.of(context).disabledColor,
                        //       // size: 24.w,
                        //     ),
                        //     style: GoogleFonts.poppins(
                        //         fontSize: 12.sp,
                        //         fontWeight: FontWeight.w500,
                        //         color: Theme.of(context).disabledColor),
                        //     items: [
                        //       'Men',
                        //       'Women',
                        //     ].map((String value) {
                        //       return DropdownMenuItem(
                        //         value: value,
                        //         child: Text(value),
                        //       );
                        //     }).toList(),
                        //   ),
                        // ),
                      ],
                    )
                  ],
                ),
                const Expanded(child: SizedBox()),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomSpacer(
                      flex: 3,
                    ),
                    Text(widget.userWear.wearTotal.toString() +
                        " " +
                        widget.userWear.wearType),
                    // Container(
                    //   height: 22.h,
                    //   width: 110.w,
                    //   decoration: BoxDecoration(
                    //     color: Theme.of(context).primaryColor,
                    //     borderRadius: BorderRadius.circular(10.w),
                    //   ),
                    //   child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //       mainAxisSize: MainAxisSize.min,
                    //       children: [
                    //         IconButton(
                    //           padding: const EdgeInsets.all(0),
                    //           onPressed: () {
                    //             _decrementCloth();
                    //           },
                    //           icon: Icon(
                    //             Icons.remove,
                    //             size: 14.w,
                    //             color: Theme.of(context).primaryColorLight,
                    //           ),
                    //         ),
                    //         Text(_numberOfClothes.toString(),
                    //             style: TextStyle(
                    //               color: Theme.of(context).primaryColorLight,
                    //             )),
                    //         IconButton(
                    //           padding: const EdgeInsets.all(0),
                    //           onPressed: () {
                    //             _incrementCloth();
                    //           },
                    //           icon: Icon(
                    //             Icons.add,
                    //             size: 14.w,
                    //             color: Theme.of(context).primaryColorLight,
                    //           ),
                    //         ),
                    //       ]),
                    // ),
                    Expanded(
                      child: Row(
                        children: [
                          ...widget.userWear.wearColor.map(
                            (e) => Container(
                              width: 11.h,
                              decoration: BoxDecoration(
                                border: e == 0xffffffff
                                    ? Border.all(color: Colors.black)
                                    : null,
                                shape: BoxShape.circle,
                                color: Color(e),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
