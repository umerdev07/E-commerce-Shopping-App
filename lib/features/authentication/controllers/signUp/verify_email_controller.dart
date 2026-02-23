import 'dart:async';

import 'package:e_commerce/common/widgets/screen/success_screen.dart';
import 'package:e_commerce/data/repository/authentication_repository.dart';
import 'package:e_commerce/utils/constants/texts.dart';
import 'package:e_commerce/utils/constants/uimages.dart';
import 'package:e_commerce/utils/popup/snack_bar_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      onSendEmailVerification();
      setTimerToAutoRedirect();
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  Future<void> onSendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();

      SnackBarHelpers.successSnackBar(
        title: 'Email sent',
        message: 'Please check your inbox and verify your email',
      );
    } catch (e) {
      SnackBarHelpers.ErrorSnackBar(
        title: 'Error',
        message: e.toString(),
      );
    }
  }

  void setTimerToAutoRedirect() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) return;

      await user.reload();

      if (user.emailVerified) {
        timer.cancel();

        Get.off(() => SuccessScreen(
          title: UTexts.accountCreatedTitle,
          subtitle: UTexts.accountCreatedSubtitle,
          image: UImages.successfullPayment,
          onTap: () => AuthenticationRepository.instance.screenRedirect(),
        ));
      }
    });
  }

  Future<void> checkEmailVerificationStatus() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.reload();

        if (user.emailVerified) {
          Get.off(() => SuccessScreen(
            title: UTexts.accountCreatedTitle,
            subtitle: UTexts.accountCreatedSubtitle,
            image: UImages.successfullPayment,
            onTap: () =>
                AuthenticationRepository.instance.screenRedirect(),
          ));
        }
      }
    } catch (e) {
      SnackBarHelpers.ErrorSnackBar(
        title: 'Error',
        message: e.toString(),
      );
    }
  }
}
