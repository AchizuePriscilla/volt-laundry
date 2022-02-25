import 'package:volt/models/process_order_model.dart';

class DeliveryDetailsArgs {
  final int numberOfWears;
  final bool? isCartOrder;
  final bool isSingleCartOrder;
  final UserWear? userWear;
  DeliveryDetailsArgs({required this.numberOfWears, this.isCartOrder = false,
      required this.isSingleCartOrder,
      this.userWear,});
}
