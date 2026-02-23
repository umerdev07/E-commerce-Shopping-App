import 'package:e_commerce/data/repository/products/products_repository.dart';
import 'package:e_commerce/features/shop/models/product_model.dart';
import 'package:e_commerce/utils/constants/enum.dart';
import 'package:e_commerce/utils/constants/texts.dart';
import 'package:get/get.dart';

import '../../../../utils/popup/snack_bar_helpers.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final _productRepository = Get.put(ProductsRepository());
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  RxBool isProductLoading = false.obs;

  @override
  void onInit() {
    getFeaturedProducts();
    super.onInit();
  }

  // Function to get 4 Products
  Future<void> getFeaturedProducts() async {
    try {
      isProductLoading.value = true;

      List<ProductModel> featuredProducts = await _productRepository
          .fetchFeaturedProducts();
      this.featuredProducts.assignAll(featuredProducts);
    } catch (e) {
      SnackBarHelpers.ErrorSnackBar(title: 'Failed', message: e.toString());
    } finally {
      isProductLoading.value = false;
    }
  }

  // Function to get All Products
  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try {
      List<ProductModel> featuredProducts = await _productRepository
          .fetchAllFeaturedProducts();
      return featuredProducts;
    } catch (e) {
      SnackBarHelpers.ErrorSnackBar(title: 'Failed', message: e.toString());
      return [];
    }
  }


  // Function to get salesPercentage
  String? calculateSalesPercentage(double originalPrice, double? salesPrice) {
    if (salesPrice == null || salesPrice <= 0.0) return null;
    if (originalPrice <= 0.0) return null;

    double salesPercentage =
        ((originalPrice - salesPrice) / originalPrice) * 100;

    return salesPercentage.toStringAsFixed(1);
  }

  // Get product price and range of variation
  String calculateAndGetProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    // If not variation than just return saleprice or price
    if (product.productType == ProductType.single.toString()) {
      return product.salesPrice > 0
          ? product.salesPrice.toString()
          : product.price.toString();
    } else {
      // Calculate the smallest and largest price among variation

      for (final variation in product.productVariations!) {
        double variationPrice = variation.salesPrice > 0
            ? variation.salesPrice
            : variation.price;

        if (variationPrice > largestPrice) {
          largestPrice = variationPrice;
        }
        if (variationPrice < smallestPrice) {
          smallestPrice = variationPrice;
        }
      }

      if (smallestPrice.isEqual(largestPrice)) {
        return largestPrice.toStringAsFixed(0);
      } else {
        return '${largestPrice.toStringAsFixed(0)} - ${UTexts.currency}${smallestPrice.toStringAsFixed(0)}';
      }
    }
  }

  String getProductStock(int stock) {
      return stock > 0 ? 'In Stock' :'Out of Stock';
  }


}
