class DeliveryDetailsArgs {
  final int numberOfWears;
  final bool? isCartOrder;
  final bool? isSingleCartOrder;
  final int? singleOrderIndex;
  DeliveryDetailsArgs({required this.numberOfWears, this.isCartOrder = false,
      this.isSingleCartOrder = false,
      this.singleOrderIndex});
}
