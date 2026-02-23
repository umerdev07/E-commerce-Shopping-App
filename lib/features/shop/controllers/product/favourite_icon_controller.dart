import 'dart:convert';

import 'package:e_commerce/data/repository/authentication_repository.dart';
import 'package:e_commerce/data/repository/products/products_repository.dart';
import 'package:e_commerce/features/shop/models/product_model.dart';
import 'package:e_commerce/utils/popup/snack_bar_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FavouriteIconController extends GetxController{
  static FavouriteIconController get instance => Get.find();

  // Variables
  RxMap<String, bool> favorites = <String, bool>{}.obs;
  final _storage = GetStorage(AuthenticationRepository.instance.currentUser!.uid);


  @override
  void onInit() {
    initFavourite();
    super.onInit();
  }

  // Load Favourite Product from local Storage
  Future<void> initFavourite() async {
      String? encodedFavourites = _storage.read('favorites');
      if(encodedFavourites == null) return;
      Map<String, dynamic> storedFavourite = jsonDecode(encodedFavourites) as Map<String, dynamic>;
      favorites.assignAll(storedFavourite.map((key, value)=> MapEntry(key, value as bool)));
  }

  // Function to add or remove favourite product
  void toggleFavoriteIcon(String productId) {
    if(favorites.containsKey(productId)) {
      favorites.remove(productId);
      saveFavouriteStorage();
      SnackBarHelpers.customToast(message: 'Product has been removed from the wishlist', bg: Colors.grey);
    }else{
      favorites[productId] = true;
      saveFavouriteStorage();
      SnackBarHelpers.customToast(message: 'Product has been added to the wishlist');

    }
  }

  // Save Favouite product in local storage
  void saveFavouriteStorage() {
    final encodeFavourite = jsonEncode(favorites);
    _storage.write('favorites', encodeFavourite);
  }


  bool isFavourite(String productId) {
    return favorites[productId] ?? false;
  }

  Future<List<ProductModel>> getFavouriteProducts() async {
    final productId = favorites.keys.toList();
    return await ProductsRepository.instance.getFavouriteProducts(productId);
  }

}