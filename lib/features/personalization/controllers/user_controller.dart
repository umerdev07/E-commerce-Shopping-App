import 'dart:io';

import 'package:e_commerce/data/repository/authentication_repository.dart';
import 'package:e_commerce/data/repository/user/user_repository.dart';
import 'package:e_commerce/features/authentication/models/user_model.dart';
import 'package:e_commerce/features/authentication/screens/login/login.dart';
import 'package:e_commerce/features/personalization/screens/edit_profile/widgets/re_authentication_user_foam.dart';
import 'package:e_commerce/features/shop/screens/product_details/product_detail.dart';
import 'package:e_commerce/utils/constants/apis.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/network_manager.dart';
import 'package:e_commerce/utils/keys/keys.dart';
import 'package:e_commerce/utils/popup/full_screen_loader.dart';
import 'package:e_commerce/utils/popup/snack_bar_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/constants/uimages.dart';
import 'package:dio/dio.dart' as dio;

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final _userRepository = Get.put(UserRepository());
  Rx<UserModel> user = UserModel.empty().obs;
  RxBool profileLoading = false.obs;

  final re_AuthenticationKey = GlobalKey<FormState>();

  final email = TextEditingController();
  final password = TextEditingController();
  RxBool isPasswordVisible = false.obs;
  RxBool isProfileUploading = false.obs;

  // Initialize User Data when user login
  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  /// Google Login User Saved
  Future<void> saveUserRecord(UserCredential usercredentials) async {
    try {
      await fetchUserData();

      if (user.value.id.isEmpty) {
        final userParts = UserModel.nameParts(
          usercredentials.user!.displayName,
        );
        final username = '${usercredentials.user!.displayName}';

        UserModel userModel = UserModel(
          id: usercredentials.user!.uid,
          firstName: userParts[0],
          lastName: userParts.length > 1 ? userParts.sublist(1).join(' ') : '',
          email: usercredentials.user!.email ?? '',
          username: username,
          phoneNumber: usercredentials.user!.phoneNumber ?? '',
          profilePicture: usercredentials.user!.photoURL ?? '',
        );

        _userRepository.saveUserCredentials(userModel);
      }
    } catch (e) {
      SnackBarHelpers.ErrorSnackBar(
        title: 'Data not saved',
        message: 'SomeThing went wrong while saving your information',
      );
    }
  }

  /// Function to fetch User
  Future<void> fetchUserData() async {
    try {
      profileLoading.value = true;
      UserModel user = await _userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      this.user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  /// Function to delete Account PopUp
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: EdgeInsets.all(USizes.md),
      title: 'Delete Account',
      middleText: 'Are you sure to delete account permanently',
      confirm: ElevatedButton(
        onPressed: () => deleteUserAccount(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: BorderSide(color: Colors.red),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: USizes.lg),
          child: Text('Delete'),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () => Get.back(),
        child: Text('Cancel'),
      ),
    );
  }

  /// Funcion to delete Account
  Future<void> deleteUserAccount() async {
    try {
      /// Start Loading Screen
      UFullScreenLoader.openLoadingDialog(
        'Processing...',
        UImages.loadingAnimation,
      );

      // ReAuthentication User
      final authRepository = AuthenticationRepository.instance;
      final provider = authRepository.currentUser!.providerData
          .map((e) => e.providerId)
          .first;

      if (provider == 'google.com') {
        await authRepository.signInWithGoogle();
        await authRepository.deleteUserAccount();
        UFullScreenLoader.stopLoading();
        Get.offAll(() => LoginScreen());
      } else if (provider == 'password') {
        UFullScreenLoader.stopLoading();
        Get.offAll(() => ReAuthenticationUserFoamScreen());
      }
    } catch (e) {
      UFullScreenLoader.stopLoading();
      SnackBarHelpers.ErrorSnackBar(title: 'Error', message: e.toString());
    }
  }

  /// Function to ReAuthenticate User
  Future<void> reAuthenticateUser() async {
    try {
      /// Start Loading
      UFullScreenLoader.openLoadingDialog(
        'Processing...',
        UImages.loadingAnimation,
      );

      /// Check Internet
      final bool isConnected = await NetworkManager.instannce.isConnected();
      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        SnackBarHelpers.warningSnackBar(
          title: 'Warning',
          message: 'No Internet',
        );
        return;
      }

      /// Validation Fields
      if (!re_AuthenticationKey.currentState!.validate()) {
        UFullScreenLoader.stopLoading();
        return;
      }

      /// Re-Authenticate User with email and password
      await AuthenticationRepository.instance
          .reAuthenticationUserWithEmailAndPassword(
            email.text.trim(),
            password.text.trim(),
          );

      /// Delete Account
      await AuthenticationRepository.instance.deleteUserAccount();

      /// Stop Laading
      UFullScreenLoader.stopLoading();

      //// Redirect
      Get.offAll(() => LoginScreen());
    } catch (e) {
      UFullScreenLoader.stopLoading();
      SnackBarHelpers.ErrorSnackBar(title: 'Failed', message: e.toString());
    }
  }

  /// Funtion to Update Profile Picture
  Future<void> updateProfilePicture() async {
    try {
      // Start Loading
      isProfileUploading.value = true;

      // Pick Image from Gallery
      XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 512,
        maxWidth: 512,
      );
      if (image == null) return;

      // Convert XFile to File
      File file = File(image.path);

      // Delete user current profile picture
      if (user.value.publicId.isNotEmpty) {
        await _userRepository.deleteImageCloudinary(user.value.publicId);
      }

      // Upload profile picture to Cloudinary
      dio.Response response = await _userRepository
          .uploadImageInCloudinary(file);

      if (response.statusCode == 200) {
        final data = response.data;
        final imageUrl = data['url'];
        final publicId = data['public_id'];

        await _userRepository.updateSingleFieldUserData({
          'ProfilePicture': imageUrl,
          'publicId': publicId,
        });

        // update profile and publicId from RX User
        user.value.profilePicture = imageUrl;
        user.value.publicId = publicId;
        user.refresh();

        SnackBarHelpers.successSnackBar(
          title: 'Congratulations',
          message: 'Profile Picture updated Successfully',
        );

      } else {
        throw 'Failed to upload Profile Image. Please try again';

      }
    } catch (e) {
      SnackBarHelpers.ErrorSnackBar(title: 'Failed', message: e.toString());
    } finally {
      isProfileUploading.value = false;
    }
  }
}
