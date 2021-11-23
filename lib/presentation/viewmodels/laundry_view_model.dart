import 'package:volt/models/navigation/laundry_details_args.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/utils.dart';

class LaundryVM extends BaseViewModel {
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

  String getServiceDesc(ServiceType serviceType) {
    switch (serviceType) {
      case ServiceType.ironing:
        return "Ironing";
      case ServiceType.dryCleaning:
        return "Dry Cleaning";
      case ServiceType.washAndIron:
        return "Wash & Iron";

      default:
        return "Unknown";
    }
  }

  String getServiceImagePath(ServiceType serviceType) {
    switch (serviceType) {
      case ServiceType.ironing:
        return "assets/images/iron.png";
      case ServiceType.dryCleaning:
        return "assets/images/dry_clean.png";
      case ServiceType.washAndIron:
        return "assets/images/wash_and_iron.png";

      default:
        return "Unknown";
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

  void navigateToLaundryDetailsView(ClothType clothType) {
    navigationHandler.pushNamed(laundryDetailsRoute,
        arg: LaundryDetailsArgs(clothType));
  }

  void navigateToCheckoutView() {
    navigationHandler.pushNamed(checkoutViewRoute);
  }
}
