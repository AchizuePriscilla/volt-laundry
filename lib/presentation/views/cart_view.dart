import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt/models/navigation/delivery_details_args.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/cart_view_model.dart';
import 'package:volt/utils/utils.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    var cartVM = context.watch<CartVM>();
    return ResponsiveWidget(
        appBar: CustomAppBar(
          text: 'Cart',
        ),
        builder: (_, size) {
          return Container(
            height: size.height,
            width: size.width,
            color: const Color(0xffF5F5F8),
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return CartItemContainer(
                        clothType: cartVM
                            .getClothTypeEnum(cartVM.userWears[index].wearType),
                        userWear: cartVM.userWears[index],
                        onTap: () {
                          cartVM.userWears.remove(cartVM.userWears[index]);
                          setState(() {});
                        },
                      );
                    },
                    itemCount: cartVM.userWears.length,
                  ),
                ),
                Visibility(
                    visible: cartVM.userWears.isNotEmpty,
                    child: Column(
                      children: [
                        Button(
                            text: 'Proceed',
                            onPressed: () {
                              cartVM.navigateToRoute(deliveryDetailsViewRoute,
                                  DeliveryDetailsArgs(numberOfWears: 2));
                            }),
                        const CustomSpacer(
                          flex: 10,
                        )
                      ],
                    ))
              ],
            ),
          );
        });
  }
}
