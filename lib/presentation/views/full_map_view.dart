import 'package:flutter/material.dart';
import 'package:volt/presentation/shared/shared.dart';

import '../../models/order_history_model.dart';

class FullMapView extends StatelessWidget {
  final Order order;
  const FullMapView({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(builder: (context, size) {
      return MapWidget(order: order);
    });
  }
}
