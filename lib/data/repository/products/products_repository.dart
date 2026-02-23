import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/data/service/cloudinary_service.dart';
import 'package:e_commerce/features/shop/models/product_category_model.dart';
import 'package:e_commerce/features/shop/models/product_model.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../../../utils/keys/keys.dart';

class ProductsRepository extends GetxController {
  static ProductsRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CloudinaryService _cloudinaryService = Get.put(CloudinaryService());

  /// Upload Products to Cloudinary & Firestore
  Future<void> uploadProducts(List<ProductModel> products) async {

    try {
      for (ProductModel product in products) {

        final Map<String,String> uploadedImageMap = {};

        // ---------- Upload Thumbnail ----------
        if (product.thumbnail.isNotEmpty) {
          File thumbFile = await UHelperFunction.assetToFile(product.thumbnail);

          dio.Response thumbResponse = await _cloudinaryService
              .uploadImageInCloudinary(thumbFile, Keys.productFolder);

          if (thumbResponse.statusCode == 200 ) {
            String url = thumbResponse.data['url'];
            uploadedImageMap[product.thumbnail] = url;
            product.thumbnail = url;
          }
        }

        // ---------- Upload Product Images ----------

        if (product.images != null && product.images!.isNotEmpty) {

          List<String> uploadedImages = [];


          for (String image in product.images!) {
            File imageFile = await UHelperFunction.assetToFile(image);

            dio.Response imageResponse = await _cloudinaryService
                .uploadImageInCloudinary(imageFile, Keys.productFolder);

            if (imageResponse.statusCode == 200) {
              uploadedImages.add(imageResponse.data['url']);
            }
          }

          // ---------- Upload Variation Images ----------
          if (product.productVariations != null &&
              product.productVariations!.isNotEmpty) {

            for(int i = 0; i<product.images!.length; i++){
              uploadedImageMap[product.images![i]] = uploadedImages[i];
            }

            for (final variation in product.productVariations!) {
              final match = uploadedImageMap.entries.firstWhere((entry) => entry.key == variation.image,
                  orElse: () => const MapEntry('', ''));

              if (match.key.isNotEmpty) {
                variation.image = match.value;
              }
            }
          }
          product.images!.clear();
          product.images!.assignAll(uploadedImages);
        }

        // ---------- Save Product to Firestore ----------
        final docId = product.id.isNotEmpty
            ? product.id
            : _db.collection(Keys.productCollection).doc().id;

        await _db
            .collection(Keys.productCollection)
            .doc(docId)
            .set(product.toJson());

        print("✅ Product uploaded: $docId");
      }
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong: $e';
    }
  }

  /// Fetch Products from Cloudinary & Firestore
  Future<List<ProductModel>> fetchFeaturedProducts() async {
    try {
      final getAllProducts = await _db
          .collection(Keys.productCollection)
          .where('isFeatured', isEqualTo: true).limit(4)
          .get();

      if (getAllProducts.docs.isNotEmpty) {
        List<ProductModel> products = getAllProducts.docs
            .map((product) => ProductModel.fromSnapshot(product))
            .toList();

        return products;
      }
      return [];
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong: $e';
    }
  }

  /// Fetch All Products from Cloudinary & Firestore
  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try {
      final getAllProducts = await _db
          .collection(Keys.productCollection)
          .where('isFeatured', isEqualTo: true)
          .get();

      if (getAllProducts.docs.isNotEmpty) {
        List<ProductModel> products = getAllProducts.docs
            .map((product) => ProductModel.fromSnapshot(product))
            .toList();

        return products;
      }
      return [];
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong: $e';
    }
  }

  /// Fetch List of Products from Cloudinary & Firestore by Query
  Future<List<ProductModel>>  fetchProductsByQuery(Query query) async {
    try {

      final querySnapshot = await query.get();

      if (querySnapshot.docs.isNotEmpty) {
        List<ProductModel> products = querySnapshot.docs
            .map((product) => ProductModel.fromQuerySnapshot(product))
            .toList();

        return products;
      }
      return [];
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong: $e';
    }
  }

  /// Fetch all List of Specific Brand Products
  Future<List<ProductModel>> getProductForBrands({required String brandId, int limit = -1}) async{
      try{
        final getAllProducts = limit == -1 ? await _db
            .collection(Keys.productCollection)
            .where('brand.id', isEqualTo: brandId)
            .get() : await _db
            .collection(Keys.productCollection)
            .where('brand.id', isEqualTo: brandId)
            .limit(limit).get();

        if (getAllProducts.docs.isNotEmpty) {
          List<ProductModel> products = getAllProducts.docs
              .map((product) => ProductModel.fromSnapshot(product))
              .toList();

          return products;
      }
        return [];
      }on FirebaseException catch (e) {
        throw UFirebaseException(e.code).message;
      } on FormatException {
        throw UFormatException();
      } on PlatformException catch (e) {
        throw UPlatformException(e.code).message;
      } catch (e) {
        throw 'Something went wrong: $e';
      }
  }

  /// [FetchProductCategory]  - Function to Fetch Product Category
  Future<List<ProductModel>> getProductCategory(String categoryId, {int limit = -1}) async {
    try{
      final productCategoryQuery = limit == -1 ? await _db.collection(Keys.productCategoryCollection).where('categoryId', isEqualTo: categoryId).get()
        : await _db.collection(Keys.productCategoryCollection).where('categoryId', isEqualTo: categoryId).limit(limit).get();

      List<String> productIds = productCategoryQuery.docs
      .map((document) => document['productId'] as String).toList();

      final productQuery = await _db.collection(Keys.productCollection).where(FieldPath.documentId, whereIn: productIds).get();

      List<ProductModel> products = productQuery.docs.map((products) => ProductModel.fromSnapshot(products)).toList();

      return products;

    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong: $e';
    }
  }

  /// Fetch Products from Cloudinary & Firestore
  Future<List<ProductModel>> getFavouriteProducts(List<String> productIds) async {
    try {
      final getAllProducts = await _db
          .collection(Keys.productCollection)
          .where(FieldPath.documentId, whereIn: productIds)
          .get();

      if (getAllProducts.docs.isNotEmpty) {
        List<ProductModel> products = getAllProducts.docs
            .map((product) => ProductModel.fromSnapshot(product))
            .toList();

        return products;
      }
      return [];
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong: $e';
    }
  }
}
