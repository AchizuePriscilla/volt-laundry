import 'package:flutter/material.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/utils/enums.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
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
                CartItemContainer(
                  clothType: ClothType.tShirt,
                  onTap: () {},
                ),
                CartItemContainer(
                  clothType: ClothType.shorts,
                  onTap: () {},
                ),
                CartItemContainer(
                  clothType: ClothType.dresses,
                  onTap: () {},
                ),
                CartItemContainer(
                  clothType: ClothType.others,
                  onTap: () {},
                ),
              ],
            ),
          );
        });
  }
}
