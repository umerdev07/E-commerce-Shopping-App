import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/data/service/cloudinary_service.dart';
import 'package:e_commerce/features/shop/models/brand_model.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import '../../../features/shop/models/brand_category_model.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../../../utils/keys/keys.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _cloudinaryService = Get.put(CloudinaryService());

  /// Upload Brand Image in Cloudinary and other data in Firebase FireStore
  Future<void> uploadBrandImageAndData(List<BrandModel> brandImage) async {
    try {
      for (BrandModel brand in brandImage) {
        File file = await UHelperFunction.assetToFile(brand.image);

        dio.Response response = await _cloudinaryService
            .uploadImageInCloudinary(file, Keys.brandFolder);

        if (response.statusCode == 200) {
          brand.image = response.data['url'];
        }

        await _db
            .collection(Keys.brandCollection)
            .doc(brand.id)
            .set(brand.toJson());

        print("Brand ${brand.name} uploaded successfully");
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

  /// Fetch Brands from Firebase Firestore
  Future<List<BrandModel>> fetchBrand() async {
    try {
      final getBrand = await _db.collection(Keys.brandCollection).get();
      if (getBrand.docs.isNotEmpty) {
        List<BrandModel> brand = getBrand.docs
            .map((brand) => BrandModel.snapShot(brand))
            .toList();

        return brand;
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

  /// [FetchBrandCategory]  - Function to Fetch Brand Category
  Future<List<BrandModel>> getAllBrandCategories(String categoryId) async {
    try {

      // Query to get all documents where categoryId matches the provided categoryId

      final brandCategoryQuery = await _db
          .collection(Keys.brandCategoryCollection)
          .where('categoryId', isEqualTo: categoryId)
          .get();

      // Convert document to model
      List<BrandCategoryModel> brandCategories = brandCategoryQuery.docs
          .map((document) => BrandCategoryModel.fromSnapShot(document))
          .toList();

      // Extract BrandIds from BrandCategoryModel
      List<String> brandsIds = brandCategories.map((brandCategory) => brandCategory.brandId).toList();

      // Query to get brands based on brandIds
      final brandQuery = await _db.collection(Keys.brandCollection).where(FieldPath.documentId, whereIn: brandsIds).limit(2).get();

      // Convert document to model
      List<BrandModel> brands = brandQuery.docs.map((brands) => BrandModel.snapShot(brands)).toList();

      // Return document
      return brands;

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
