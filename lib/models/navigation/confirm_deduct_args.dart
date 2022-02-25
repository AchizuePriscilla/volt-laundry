import 'package:volt/models/process_order_model.dart';

class ConfirmDeductArgs {
  final double amount;
  final int deliveryFee;
  final bool isCartOrder;
  final bool isSingleCartOrder;
  final UserWear? userWear;
  ConfirmDeductArgs(
      {required this.amount,
      required this.deliveryFee,
      required this.isCartOrder,
      this.userWear,
      this.isSingleCartOrder = false,});
}
