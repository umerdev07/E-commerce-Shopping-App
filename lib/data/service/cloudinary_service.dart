import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import '../../utils/constants/apis.dart';
import '../../utils/keys/keys.dart';

class CloudinaryService extends GetxController {
  static CloudinaryService get instance => Get.find();

  final _dio = dio.Dio();

  // [Upload  Image in Cloudinary]
  Future<dio.Response> uploadImageInCloudinary(
    File image,
    String folderName,
  ) async {
    try {
      final String api = UApiUrls.uploadApi(Keys.cloudName);

      final dio.FormData formData = dio.FormData.fromMap({
        'upload_preset': Keys.uploadPreset,
        'folder': folderName,
        'file': await dio.MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
      });

      final dio.Response response = await _dio.post(
        api,
        data: formData,
        options: dio.Options(headers: {'Content-Type': 'multipart/form-data'}),
      );

      return response;
    } catch (e) {
      throw 'Failed to upload profile image. Please try again!';
    }
  }

  /// Delete Current Image in Cloudinary to Override the previous image to other current image
  Future<dio.Response> deleteImageCloudinary(String publicId) async {
    try {
      final api = UApiUrls.destroyApi(Keys.cloudName);

      int timeStamp = (DateTime.now().microsecondsSinceEpoch / 1000).round();

      String signatureBase =
          'public_id=$publicId&timestamp=$timeStamp${Keys.apiSecret}';
      String signature = sha1.convert(utf8.encode(signatureBase)).toString();

      final formData = dio.FormData.fromMap({
        'public_id': publicId,
        'api_key': Keys.apiKey,
        'timestamp': timeStamp,
        'signature': signature,
      });

      final dio.Response response = await _dio.post(api, data: formData);

      return response;
    } catch (e) {
      throw 'Failed to update profile image. Please try again!';
    }
  }
}
