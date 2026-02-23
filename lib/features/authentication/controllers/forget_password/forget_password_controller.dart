import 'package:e_commerce/data/repository/authentication_repository.dart';
import 'package:e_commerce/features/authentication/screens/forgetPassword/resetPassword.dart';
import 'package:e_commerce/utils/constants/uimages.dart';
import 'package:e_commerce/utils/helpers/network_manager.dart';
import 'package:e_commerce/utils/popup/full_screen_loader.dart';
import 'package:e_commerce/utils/popup/snack_bar_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  final forgotPasswordKey = GlobalKey<FormState>();

  final email = TextEditingController();

  Future<void> forgetPasswordThroughEmail() async {
    try {
      // Check if form is valid
      if (!forgotPasswordKey.currentState!.validate()) return;

      // Show Loader
      UFullScreenLoader.openLoadingDialog(
        'Processing your request...',
        UImages.loadingAnimation,
      );

      // Check Internet Connection
      bool isConnected = await NetworkManager.instannce.isConnected();
      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        SnackBarHelpers.ErrorSnackBar(
          title: 'Error',
          message: 'No Internet Connection',
        );
        return;
      }

      // Send Reset Password Email
      final status = await AuthenticationRepository.instance.forgetPasswordThroughEmail(
        email.text.trim(),
      );

      // Stop Loader
      UFullScreenLoader.stopLoading();


      // Show Status Message
      if(status == true){
        SnackBarHelpers.successSnackBar(
          title: 'Success',
          message: 'Reset link sent to your email',
        );

        // Redirect after short delay
        Get.offAll(() => ResetPasswordScreen(text: email.text.trim()));
      }else{
        SnackBarHelpers.warningSnackBar(title: 'Warning', message: 'Email is not registered');
      }


    } catch (e) {
      UFullScreenLoader.stopLoading();
      SnackBarHelpers.ErrorSnackBar(title: 'Error', message: e.toString());
    }
  }

  Future<void> resendPasswordThroughEmail(String isemail) async {
    try {
      // Show Loader
      UFullScreenLoader.openLoadingDialog(
        'Processing your request...',
        UImages.loadingAnimation,
      );

      // Check Internet Connection
      bool isConnected = await NetworkManager.instannce.isConnected();
      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        SnackBarHelpers.ErrorSnackBar(
          title: 'Error',
          message: 'No Internet Connection',
        );
        return;
      }

      // Send Reset Password Email
      final isSent = await AuthenticationRepository.instance
          .forgetPasswordThroughEmail(isemail.trim().toLowerCase());

      // Stop Loader
      UFullScreenLoader.stopLoading();

      // Show Status Message
      if (isSent) {
        SnackBarHelpers.successSnackBar(
          title: 'Success',
          message: 'Reset link sent to your email',
        );
      } else {
        SnackBarHelpers.warningSnackBar(
          title: 'Warning',
          message: 'Email is not registered',
        );
      }
    } catch (e) {
      UFullScreenLoader.stopLoading();
      SnackBarHelpers.ErrorSnackBar(title: 'Error', message: e.toString());
    }
  }


}
