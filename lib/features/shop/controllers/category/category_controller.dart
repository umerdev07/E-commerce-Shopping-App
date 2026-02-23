import 'package:e_commerce/data/repository/category/category_repository.dart';
import 'package:e_commerce/features/shop/models/category_model.dart';
import 'package:e_commerce/utils/popup/snack_bar_helpers.dart';
import 'package:get/get.dart';

import '../../../../data/repository/products/products_repository.dart';
import '../../models/product_model.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategory = <CategoryModel>[].obs;
  RxList<CategoryModel> isFeaturedCategory = <CategoryModel>[].obs;
  RxBool isCategoryLoading = false.obs;

  @override
  void onInit() {
    fetchAllCategory();
    super.onInit();

  }

  Future<void> fetchAllCategory() async {
    try {
      isCategoryLoading.value == true;

      List<CategoryModel> category = await _categoryRepository
          .getAllCategories();
      allCategory.assignAll(category);
      isFeaturedCategory.assignAll(
        (category.where(
          (category) => category.isFeaturedId && category.parentId.isEmpty,
        )),
      );
    } catch (e) {
      SnackBarHelpers.ErrorSnackBar(title: 'Failed', message: e.toString());
    } finally {
      isCategoryLoading.value == false;
    }
  }

  // Get Products With Specific Category
  Future<List<ProductModel>> getProductCategories({required String categoryId, int limit = 4}) async {
    try{
      List<ProductModel> products = await ProductsRepository.instance.getProductCategory(categoryId,limit: limit);
      return products;

    }catch (e) {
      SnackBarHelpers.ErrorSnackBar(title: 'Failed', message: e.toString);
      return [];
    }
  }

  // Fetch SubCategory
  Future<List<CategoryModel>> getProductSubcategory(String categoryId) async {
    try{
      
      final subCategories = await _categoryRepository.getSubCategories(categoryId);
      return subCategories;
    }catch(e){
      SnackBarHelpers.ErrorSnackBar(title: 'Failed', message: e.toString);
      return [];
    }
  }
}
