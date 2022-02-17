import 'package:volt/presentation/viewmodels/base_view_model.dart';
import 'package:volt/utils/utils.dart';

import '../../models/process_order_model.dart';

class CartVM extends BaseViewModel {
  List<UserWear> userWears = <UserWear>[];

  void navigateToRoute(String route, dynamic args) {
    navigationHandler.pushNamed(route, arg: args);
  }

  ClothType getClothTypeEnum(String wearType) {
    switch (wearType) {
      case "T-Shirts":
        return ClothType.tShirt;
      case "Shorts":
        return ClothType.shorts;
      case "Cardigans":
        return ClothType.cardigans;
      case "Dresses":
        return ClothType.dresses;
      case "Home":
        return ClothType.home;
      case "Others":
        return ClothType.others;

      default:
        return ClothType.others;
    }
  }

String getImagePath(ClothType clothType) {
    switch (clothType) {
      case ClothType.tShirt:
        return "shirt";
      case ClothType.shorts:
        return "trousers";
      case ClothType.cardigans:
        return "cardigan";
      case ClothType.dresses:
        return "dress";
      case ClothType.home:
        return "home";
      case ClothType.others:
        return "tie";

      default:
        return "Unknown";
    }
  }
 String getServiceType(ServiceType serviceType) {
    switch (serviceType) {
      case ServiceType.ironing:
        return "IRON";
      case ServiceType.dryCleaning:
        return "DRY_CLEAN";
      case ServiceType.washAndIron:
        return "WASH_IRON";

      default:
        return "Unknown";
    }
  }

String getDesc(ClothType clothType) {
    switch (clothType) {
      case ClothType.tShirt:
        return "T-Shirts";
      case ClothType.shorts:
        return "Shorts";
      case ClothType.cardigans:
        return "Cardigans";
      case ClothType.dresses:
        return "Dresses";
      case ClothType.home:
        return "Home";
      case ClothType.others:
        return "Others";

      default:
        return "Unknown";
    }
  }
  void addToCart(
      {required ClothType clothType,
      required List<dynamic> wearColor,
      required int wearTotal,
      required int amount,
      required ServiceType serviceType}) {
    userWears.add(UserWear(
        wearType: getDesc(clothType),
        wearColor: wearColor,
        wearTotal: wearTotal,
        price: DeliveryFee(currency: 'VLTCOIN', amount: amount),
        serviceType: getServiceType(serviceType)));
  }
}
