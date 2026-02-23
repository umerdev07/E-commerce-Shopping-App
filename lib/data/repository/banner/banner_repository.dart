import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/data/service/cloudinary_service.dart';
import 'package:e_commerce/features/shop/models/banner_model.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../../../utils/keys/keys.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  // Variables
  final _db = FirebaseFirestore.instance;
  final _cloudinaryServices = Get.put(CloudinaryService());

  /// [Upload Banner] - Function to upload Banner
  Future<void> uploadBanner(List<BannerModel> banners) async {
    try {
      for (final banner in banners) {
        File file = await UHelperFunction.assetToFile(banner.imageUrl);

        dio.Response response = await _cloudinaryServices
            .uploadImageInCloudinary(file, Keys.brandFolder);

        if (response.statusCode == 200) {
          banner.imageUrl = response.data['url'];
        }

        await _db.collection(Keys.brandCollection).doc().set(banner.toJson());
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

  /// [Fetch Banner] - Function to upload Banner
  Future<List<BannerModel>> fetchBanner() async {
    try {
      final getBanner = await _db.collection(Keys.bannerCollection).where('active', isEqualTo: true).get();

      if (getBanner.docs.isNotEmpty) {
        List<BannerModel> banner = getBanner.docs
            .map((document) => BannerModel.fromsnapShot(document))
            .toList();

        return banner;
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
