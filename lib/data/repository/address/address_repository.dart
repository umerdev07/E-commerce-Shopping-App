import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/data/repository/authentication_repository.dart';
import 'package:e_commerce/features/personalization/models/address_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../../../utils/keys/keys.dart';

class AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  /// [Upload] Address
  Future<String> uploadAddress(AddressModel address) async {
    try {
      final userId = AuthenticationRepository.instance.currentUser!.uid;
      final currentAddress = await _db
          .collection(Keys.userCollections)
          .doc(userId)
          .collection(Keys.addressCollection)
          .add(address.toJson());
      return currentAddress.id;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while saving Address Information. Please try again';
    }
  }

  /// [Fetch] Address
  Future<List<AddressModel>> fetchAddress() async {
    try {
      final userId = AuthenticationRepository.instance.currentUser!.uid;
      if (userId.isEmpty) throw 'User not found! Plz login again';
      final query = await _db
          .collection(Keys.userCollections)
          .doc(userId)
          .collection(Keys.addressCollection)
          .get();
      if (query.docs.isNotEmpty) {
        List<AddressModel> addresses = query.docs
            .map((address) => AddressModel.fromDocumentSnapshot(address))
            .toList();
        return addresses;
      }
      return [];
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Unable to find addresses. Please try again';
    }
  }

  /// [UpdateSelectedAddress]
  Future<void> updateSelectedAddress(String addressId, bool isSelected) async {
    try {
      final userId = AuthenticationRepository.instance.currentUser!.uid;
      await _db
          .collection(Keys.userCollections)
          .doc(userId)
          .collection(Keys.addressCollection)
          .doc(addressId)
          .update({'selectedAddress': isSelected});
    } catch (e) {
      throw 'Unable to update selected address! Please try again';
    }
  }
}
