import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/utils.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    var laundryVM = context.read<LaundryVM>();
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
            child: ListView(
              children: [
                const CartItemContainer(
                  clothType: ClothType.tShirt,
                ),
                const CartItemContainer(
                  clothType: ClothType.shorts,
                ),
                const CartItemContainer(
                  clothType: ClothType.dresses,
                ),
                const CartItemContainer(
                  clothType: ClothType.others,
                ),
                const CustomSpacer(flex: 7),
                Button(
                    text: 'Proceed',
                    onPressed: () {
                      laundryVM.navigateToRoute(deliveryDetailsViewRoute);
                    }),
              ],
            ),
          );
        });
  }
}
