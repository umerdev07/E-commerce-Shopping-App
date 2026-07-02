import 'package:e_commerce/data/repository/authentication_repository.dart';
import 'package:e_commerce/features/shop/controllers/product/variation_controller.dart';
import 'package:e_commerce/features/shop/models/cart_item_model.dart';
import 'package:e_commerce/features/shop/models/product_model.dart';
import 'package:e_commerce/features/shop/models/product_variation_model.dart';
import 'package:e_commerce/features/shop/screens/cart/cart.dart';
import 'package:e_commerce/utils/constants/enum.dart';
import 'package:e_commerce/utils/popup/snack_bar_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../utils/keys/keys.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  // Variables
  final _storage = GetStorage(AuthenticationRepository.instance.currentUser!.uid);
  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItem = <CartItemModel>[].obs;

  final variationController = VariationController.instance;


  @override
  void onInit() {
    super.onInit();
  }

  void loadCartItems() {
    List<dynamic>? storedCardItems = _storage.read(Keys.cartItemKeys);
    if(storedCardItems != null) {
      cartItem.assignAll(storedCardItems.map((item) => CartItemModel.fromJson(item as Map<String, dynamic>)));
      updateCartTotals();
    }
  }

  /// Add items in the cart
  void addToCart(ProductModel product) {
    // Check the qunatity
    if (productQuantityInCart.value < 1) {
      SnackBarHelpers.customToast(message: 'Select Quantity');
      return;
    }

    // Check Variation of product if it is variable product
    if (product.productType == ProductType.variable.toString() &&
        variationController.selectedVariation.value.id.isEmpty) {
      SnackBarHelpers.customToast(message: 'Select Variation');
      return;
    }

    // Out of Stock Status
    if (product.productType == ProductType.variable.toString()) {
      if (variationController.selectedVariation.value.stock < 1) {
        SnackBarHelpers.customToast(message: 'This variation is out of Stock');
        return;
      } else{
        if (product.stock < 1) {
          SnackBarHelpers.customToast(message: 'This product is out of Stock');
          return;
        }
      }
    }

    // Convert the ProductModel to CartItemModel with given Quantity

    CartItemModel selectedCartItem = convertToCartItem(product, productQuantityInCart.value);

    // Check if already added
    int index = cartItem.indexWhere((cartItem) => cartItem.productId == selectedCartItem.productId &&
        selectedCartItem.variationId == cartItem.variationId);

    if(index >= 0) {
      cartItem[index].quantity = selectedCartItem.quantity;
    }else{
      cartItem.add(selectedCartItem);
    }

    // updateCart
    updateCard();
    
    SnackBarHelpers.customToast(message: 'Your product has been added to the cart');
  }

  /// Add One Item in Cart
  void addOneToCart(CartItemModel item) {
    int index = cartItem.indexWhere((cartItem) => item.productId == cartItem.productId && item.variationId == cartItem.variationId);

    if(index >= 0){
      cartItem[index].quantity += 1;
    }else{
      cartItem.add(item);
    }

    updateCard();
  }

  /// Remove one item from the cart
  void removeOneFromCart(CartItemModel item)  {
    int index = cartItem.indexWhere((cartItem) => item.productId == cartItem.productId && item.variationId == cartItem.variationId);

    if(index >= 0 ) {
      if(cartItem[index].quantity > 1) {
        cartItem[index].quantity -= 1;
        updateCard();
      }else{
        removeFromCartDialog(index);
      }
    }
  }

  void removeFromCartDialog(int index) {
    Get.defaultDialog(
      title: 'Remove Product',
      middleText: 'Are you sure you want to remove this Product?',
      onConfirm: () {
        Get.back(); // Close dialog first

        cartItem.removeAt(index);
        updateCard();

        SnackBarHelpers.customToast(
          message: 'Product removed from the cart',
        );
      },
      onCancel: () => Get.back(),
    );
  }

  /// Get Total Quantity of same specific Product
  int getProductQuantityInCart(String productId){
    final item = cartItem.where((cartItem) => cartItem.productId == productId).fold(
        0,(previousValue, cartItem) => previousValue + cartItem.quantity);
      return item;
  }

  /// Get Total Quantity of variation of specific Product
  int getVariationQuantityInCart(String productId , String variationId){
    CartItemModel cartItemModel = cartItem.firstWhere((item) => item.productId == productId && item.variationId == variationId,
    orElse: () => CartItemModel.isEmpty());
    return cartItemModel.quantity;
  }

  /// [UPDATE CART]
  void updateCard(){
    updateCartTotals();
    saveCartItems();
    cartItem.refresh();
  }

  // save cart item into local Storage
  void saveCartItems() {
    List<Map<String, dynamic>> cartItemList = cartItem.map((item) => item.toJson()).toList();
    _storage.write(Keys.cartItemKeys, cartItemList);
  }

  // Update cart totals
  void updateCartTotals() {
    double calculateTotalPrices = 0.0;
    int calculateNoOfItems = 0;

    for(final item in cartItem){
      calculateTotalPrices += (item.price) * item.quantity.toDouble();
      calculateNoOfItems += item.quantity;
    }

    totalCartPrice.value = calculateTotalPrices;
    noOfCartItems.value = calculateNoOfItems;
  }

  // Convert productModel to CartItemModel

  CartItemModel  convertToCartItem(ProductModel product, int quantity){
      if(product.productType == ProductType.single.toString()){
        variationController.resetSelectedAttributes();
      }

      ProductVariationModel variation =   variationController.selectedVariation.value;
      bool isVariation = variation.id.isNotEmpty;
      String image = isVariation ? variation.image : product.thumbnail;
      double price = isVariation ? variation.salesPrice > 0 ? variation.salesPrice : variation.price
            : product.salesPrice > 0 ? product.salesPrice : product.price;

      return CartItemModel(
          productId: product.id,
          quantity: quantity,
        title: product.title,
          brandName: product.brand != null ? product.brand!.name : '',
        image: image,
        price: price,
        selectedVariation: isVariation ? variation.attributesValues : null,
        variationId: variation.id
      );


  }

  // Initialize already added items count in the cart
  void updateAlreadyUpdateProductCount(ProductModel product) {
    if(product.productType == ProductType.single.toString()){
      productQuantityInCart.value = getProductQuantityInCart(product.id);
    }else{
      String variationId = variationController.selectedVariation.value.id;
      if(variationId.isNotEmpty){
        productQuantityInCart.value = getVariationQuantityInCart(product.id, variationId);
      }else{
        productQuantityInCart.value = 0;
      }
    }
  }

  // Clear Cart
  void clearCart() {
    productQuantityInCart.value = 0;
    cartItem.clear();
    updateCard();

  }
}
