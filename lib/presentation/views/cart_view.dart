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
    return ResponsiveWidget(builder: (_, size) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            CartItemContainer(
              clothType: ClothType.tShirt,
              onTap: () {},
            ),
          ],
        ),
      );
    });
  }
}
