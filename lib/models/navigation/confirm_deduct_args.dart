class ConfirmDeductArgs {
  final double amount;
  final int deliveryFee;
  final bool isCartOrder;
  final bool? isSingleCartOrder;
  final int? singleOrderIndex;
  ConfirmDeductArgs(
      {required this.amount,
      required this.deliveryFee,
      required this.isCartOrder,
      this.isSingleCartOrder = false,
      this.singleOrderIndex});
}
