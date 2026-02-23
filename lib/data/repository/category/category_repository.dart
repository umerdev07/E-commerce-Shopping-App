import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/data/service/cloudinary_service.dart';
import 'package:e_commerce/features/shop/models/brand_category_model.dart';
import 'package:e_commerce/features/shop/models/category_model.dart';
import 'package:e_commerce/features/shop/models/product_category_model.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:e_commerce/utils/keys/keys.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  // Variables
  final _db = FirebaseFirestore.instance;
  final _cloudinaryServices = Get.put(CloudinaryService());

  /// [UploadBrandCategoru] - Function to upload brand Category
  Future<void> uploadBrandCategory(List<BrandCategoryModel> brandCategory) async {
    try {
      for (final brandCategories in brandCategory) {
         await _db
            .collection(Keys.brandCategoryCollection)
            .doc()
            .set(brandCategories.toJson());
      }
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (_) {
      throw 'Something went wrong! Please try again';
    }
  }

  /// [UploadProductCategoru] - Function to upload brand Category
  Future<void> uploadProductCategory(List<ProductCategoryModel> productCategory) async {
    try {
      for (final productCategories in productCategory) {
        await _db
            .collection(Keys.productCategoryCollection)
            .doc()
            .set(productCategories.toJson());
      }
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (_) {
      throw 'Something went wrong! Please try again';
    }
  }

  /// [UploadCategory] - Function to upload Category

  Future<void> uploadCategory(List<CategoryModel> categories) async {
    try {
      for (final category in categories) {
        File file = await UHelperFunction.assetToFile(category.image);

        dio.Response response = await _cloudinaryServices
            .uploadImageInCloudinary(file, Keys.categoryFolder);

        if (response.statusCode == 200) {
          category.image = response.data['url'];
        }

        await _db
            .collection(Keys.categoryCollection)
            .doc(category.id)
            .set(category.toJson());
      }
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (_) {
      throw 'Something went wrong! Please try again';
    }
  }

  /// [FetchCategory] - Function to Fetch Category
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final query = await _db.collection(Keys.categoryCollection).get();

      if (query.docs.isNotEmpty) {
        List<CategoryModel> categories = query.docs
            .map((document) => CategoryModel.fromSnapshot(document))
            .toList();
        return categories;
      }

      return [];
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (_) {
      throw 'Something went wrong! Please try again';
    }
  }

  /// [FetchSubCategory] - Function to Fetch Sub Category
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final query = await _db.collection(Keys.categoryCollection).where('parentId', isEqualTo: categoryId).get();

      if (query.docs.isNotEmpty) {
        List<CategoryModel> categories = query.docs
            .map((document) => CategoryModel.fromSnapshot(document))
            .toList();
        return categories;
      }

      return [];
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (_) {
      throw 'Something went wrong! Please try again';
    }
  }

}
