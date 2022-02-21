import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt/models/navigation/delivery_details_args.dart';
import 'package:volt/models/process_order_model.dart';
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
  void initState() {
    super.initState();
    context.read<CartVM>().getUserCart();
  }

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
            child: FutureBuilder<List<UserWear>>(
                future: context.watch<CartVM>().getUserCart(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var items = snapshot.data;
                    return RefreshIndicator(
                      onRefresh: () async {
                        await context.read<CartVM>().getUserCart();
                      },
                      child: items!.isEmpty
                          ? const EmptyContainer(message: 'Cart items')
                          : Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return CartItemContainer(
                                        clothType: cartVM.getClothTypeEnum(
                                            items[index].wearType),
                                            singleOrderIndex: index,
                                        userWear: items[index],
                                        onDelete: () async {
                                          // await cartVM
                                          //     .deleteFromCart(items[index]);
                                          items.remove(items[index]);
                                          setState(() {});
                                        },
                                      );
                                    },
                                    itemCount: items.length,
                                  ),
                                ),
                                Visibility(
                                  visible: items.isNotEmpty,
                                  child: Column(
                                    children: [
                                      Button(
                                          text: 'Proceed',
                                          onPressed: () {
                                            cartVM.navigateToRoute(
                                                deliveryDetailsViewRoute,
                                                DeliveryDetailsArgs(
                                                    numberOfWears:
                                                        cartVM.totalUserWears,
                                                    isCartOrder: true));
                                          }),
                                      const CustomSpacer(
                                        flex: 10,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Sorry, an error occured, try again'),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
          );
        });
  }
}
