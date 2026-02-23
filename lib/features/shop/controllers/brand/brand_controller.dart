import 'package:e_commerce/data/repository/brand/brand_repository.dart';
import 'package:e_commerce/data/repository/products/products_repository.dart';
import 'package:e_commerce/features/shop/models/brand_model.dart';
import 'package:e_commerce/features/shop/models/product_model.dart';
import 'package:e_commerce/utils/popup/snack_bar_helpers.dart';
import 'package:get/get.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  // Variables
  final _brandRepository = Get.put(BrandRepository());
  RxList<BrandModel> allBrands = <BrandModel>[].obs;
  RxList<BrandModel> isFeature = <BrandModel>[].obs;

  RxBool isBrandLoading = false.obs;
  @override
  void onInit() {
    getBrands();
    super.onInit();
  }

  // Fetch Brand
  Future<void> getBrands() async {
    try {

      isBrandLoading.value = true;


      // Fetch brand list from repo
      List<BrandModel> brands = await _brandRepository.fetchBrand();

      // Assign brand list in allBrands List
      allBrands.assignAll(brands);

      isFeature.assignAll(
        allBrands.where((element) => element.isFeatured ?? false).toList(),
      );

    } catch (e) {
      SnackBarHelpers.ErrorSnackBar(title: 'Failed', message: e.toString);
    }finally{
      isBrandLoading.value = false;
    }
  }

  // Get Brands With Specific Products
  Future<List<ProductModel>> getSpecificBrandProducts(String brandId,
      {int limit = -1}) async {
    try{

      List<ProductModel> products = await ProductsRepository.instance.getProductForBrands(brandId: brandId, limit: limit);
      return products;
    } catch (e) {
      SnackBarHelpers.ErrorSnackBar(title: 'Failed', message: e.toString);
      return [];
    }
  }

  // Get Brands With Specific Products
  Future<List<BrandModel>> getBrandCategories(String categoryId) async {
    try{

      List<BrandModel> brands = await BrandRepository.instance.getAllBrandCategories(categoryId);
      return brands;

    } catch (e) {
      SnackBarHelpers.ErrorSnackBar(title: 'Failed', message: e.toString);
      return [];
    }
  }
}
