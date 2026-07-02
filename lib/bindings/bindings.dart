import 'package:e_commerce/utils/helpers/network_manager.dart';
import 'package:get/get.dart';

import '../features/shop/controllers/checkout/checkout_controller.dart';
import '../features/shop/controllers/product/variation_controller.dart';

class UBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(VariationController());
    Get.put(CheckoutController());
  }

}