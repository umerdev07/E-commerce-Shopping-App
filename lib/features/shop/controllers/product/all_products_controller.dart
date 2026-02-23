import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/data/repository/products/products_repository.dart';
import 'package:e_commerce/features/shop/models/product_model.dart';
import 'package:e_commerce/utils/popup/snack_bar_helpers.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AllProductsController extends GetxController{
  static AllProductsController get instance => Get.find();

  final _productRepository = ProductsRepository.instance;
  final RxString selectedSortOption = 'Name'.obs;
  final RxList<ProductModel> product = <ProductModel>[].obs;


  Future<List<ProductModel>> fetchProductFromQuery(Query? query) async {
    try{
        if(query == null) return [];

        List<ProductModel>  products = await _productRepository.fetchProductsByQuery(query);
        return products;
    }catch(e){
      SnackBarHelpers.ErrorSnackBar(title: 'Failed', message: e.toString());
      return [];
    }
  }

  void sortProduct(String sortOption){
      selectedSortOption.value = sortOption;

     switch(sortOption){
       case 'Name':
         product.sort((a , b) => a.title.compareTo(b.title));
         break;
       case 'Lower Price':
          product.sort((a , b) => a.price.compareTo(b.price));
         break;
       case 'Higher Price':
         product.sort((a, b) => b.price.compareTo(a.price));
         break;
       case 'Newest':
         product.sort((a, b) => a.date!.compareTo(b.date!));
         break;
       case 'Sale':
         product.sort((a, b) {
           if(b.salesPrice > 0){
             return b.salesPrice.compareTo(a.salesPrice);
           }else if(a.salesPrice > 0){
             return - 1;
           }else{
             return 1;
           }
         });
         break;
         default:

     }
  }
  void assignProduct(List<ProductModel> products){
    product.value = products;
    sortProduct('Name');
  }

}