import 'package:e_commerce/data/repository/user/user_repository.dart';
import 'package:e_commerce/features/authentication/models/user_model.dart';
import 'package:e_commerce/features/authentication/screens/signup/verify_email.dart';
import 'package:e_commerce/utils/constants/uimages.dart';
import 'package:e_commerce/utils/helpers/network_manager.dart';
import 'package:e_commerce/utils/popup/full_screen_loader.dart';
import 'package:e_commerce/utils/popup/snack_bar_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/repository/authentication_repository.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  RxBool isPasswordVisible = false.obs;
  RxBool privacyPolicy = false.obs;
  final signUpKey = GlobalKey<FormState>();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();

  Future<void> registered() async {
    try {
      if ( !signUpKey.currentState!.validate()) return;

      // Start Loading
      UFullScreenLoader.openLoadingDialog(
        'We are processing your information...',
        UImages.loadingAnimation,
      );

      // Check Internet Availability
      bool isConnected = await NetworkManager.instannce.isConnected();
      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        SnackBarHelpers.warningSnackBar(title: 'No Internet Connection');
        return;
      }

      // Check Privacy Policy
      if (!privacyPolicy.value) {
        UFullScreenLoader.stopLoading();
        SnackBarHelpers.warningSnackBar(
          title: 'Accept Privacy Policy',
          message: 'Please accept the privacy policy to continue.',
        );
      }

      UserCredential userCredential = await AuthenticationRepository.instance.registered(
        email.text.trim(),
        password.text.trim(),
      );

      // User UserModel
      UserModel userModel = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text,
        lastName: lastName.text,
        email: email.text,
        username: firstName.text + lastName.text,
        phoneNumber: phoneNumber.text,
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());

      // save user credentials
      await userRepository.saveUserCredentials(userModel);

      // success loading
      SnackBarHelpers.successSnackBar(
        title: 'Congratulations!',
        message:
            'Your account has been created! Plz verify yout email first than continue',
      );

      // Stop Loading
      UFullScreenLoader.stopLoading();

      // redirect to verify email screen
      Get.to(() => VerifyEmailScreen(email: email.text));
    } catch (e) {
      UFullScreenLoader.stopLoading();
      SnackBarHelpers.ErrorSnackBar(title: 'Error', message: e.toString());
    }
  }
}
