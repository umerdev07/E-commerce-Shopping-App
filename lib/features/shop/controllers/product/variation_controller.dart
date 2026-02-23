import 'package:e_commerce/features/shop/controllers/product/image_controller.dart';
import 'package:e_commerce/features/shop/models/product_model.dart';
import 'package:e_commerce/features/shop/models/product_variation_model.dart';
import 'package:get/get.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();

  // Variable
  RxMap<String, String> selectedAttributes = <String, String> {}.obs;
  Rx<ProductVariationModel> selectedVariation =
      ProductVariationModel.empty().obs;
  RxString variationStockStatus = ''.obs;

  void onAttributeSelected(
      ProductModel product,
      String attributeName,
      String attributeValue,
      ) {
    // Update selected attribute directly
    selectedAttributes[attributeName] = attributeValue;

    // Find matching variation
    final variation = product.productVariations!.firstWhere(
          (v) => isSameAttributesValues(v.attributesValues, selectedAttributes),
      orElse: () => ProductVariationModel.empty(),
    );

    // Update image
    if (variation.image.isNotEmpty) {
      ImageController.instance.selectedProductImage.value = variation.image;
    }

    // Update selected variation
    selectedVariation.value = variation;

    // Update stock status
    getVariationStockStatus();
  }


  bool isSameAttributesValues(
    Map<String, dynamic> variationAttributes,
    Map<String, dynamic> selectedAttributes,
  ) {
    // if selected Attribute contain 3 attribute and currect variation contain 2 then return
    if (variationAttributes.length != selectedAttributes.length) return false;

    // if any of the attribute is different then return ['Green', Large] != ['Green', Small]
    for (final key in variationAttributes.keys) {
      if (variationAttributes[key] != selectedAttributes[key]) return false;
    }
    return true;
  }

  Set<String> getAttributeAvailabilityInVariation(
      List<ProductVariationModel> variations,
      String attributeName,
      ) {
    return variations
        .where((variation) =>
    variation.attributesValues.containsKey(attributeName) &&
        variation.attributesValues[attributeName] != null &&
        variation.attributesValues[attributeName]!.isNotEmpty &&
        variation.stock > 0)
        .map((variation) => variation.attributesValues[attributeName]!)
        .toSet();
  }


  void getVariationStockStatus() {
    variationStockStatus.value = selectedVariation.value.stock > 0
        ? 'In Stock'
        : 'Out of Stock';
  }

  String getVariationPrice() {
    return (selectedVariation.value.salesPrice > 0
            ? selectedVariation.value.salesPrice
            : selectedVariation.value.price)
        .toStringAsFixed(0);
  }
}
