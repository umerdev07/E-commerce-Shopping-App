import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:e_commerce/data/repository/authentication_repository.dart';
import 'package:e_commerce/data/service/cloudinary_service.dart';
import 'package:e_commerce/features/authentication/models/user_model.dart';
import 'package:e_commerce/utils/constants/apis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../../../utils/keys/keys.dart';
import 'package:dio/dio.dart' as dio;

class UserRepository {
  static UserRepository get instance => Get.find();
  final _cloudinaryService = Get.put(CloudinaryService());

  // vairiacle
  final _db = FirebaseFirestore.instance;

  /// [SAVE USER]
  Future<void> saveUserCredentials(UserModel user) async {
    try {
      await _db
          .collection(Keys.userCollections)
          .doc(user.id)
          .set(user.toJson());
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'SomeThing went wrong! Plz try again';
    }
  }

  /// [READ USERDATA]
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection(Keys.userCollections)
          .doc(AuthenticationRepository.instance.currentUser!.uid)
          .get();

      if (documentSnapshot.exists) {
        UserModel userModel = UserModel.fromSnapshot(documentSnapshot);
        return userModel;
      }

      return UserModel.empty();
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'SomeThing went wrong! Plz try again';
    }
  }

  /// [Update UserData]
  Future<void> updateSingleFieldUserData(Map<String, dynamic> map) async {
    try {
      await _db
          .collection(Keys.userCollections)
          .doc(AuthenticationRepository.instance.currentUser!.uid)
          .update(map);
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'SomeThing went wrong! Plz try again';
    }
  }

  /// [Remove User Account]
  Future<void> removeUserAccount(String userId) async {
    try {
      await _db.collection(Keys.userCollections).doc(userId).delete();
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'SomeThing went wrong! Plz try again';
    }
  }

  // [Upload Profile Image in Cloudinary]
  Future<dio.Response> uploadImageInCloudinary(File image) async {
    try {
      dio.Response response = await _cloudinaryService.uploadImageInCloudinary(
        image,
        Keys.profileEditor,
      );

      return response;
    } catch (e) {
      throw 'Failed to upload profile image. Please try again!';
    }
  }

  /// Delete Current Profile Image in Cloudinary to Override the previous image to other current image
  Future<dio.Response> deleteImageCloudinary(String publicId) async {
    try {
      dio.Response response = await _cloudinaryService.deleteImageCloudinary(
        publicId,
      );
      return response;
    } catch (e) {
      throw 'Failed to update profile image. Please try again!';
    }
  }
}
