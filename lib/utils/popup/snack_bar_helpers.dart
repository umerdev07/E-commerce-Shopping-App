import 'package:e_commerce/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SnackBarHelpers {

  // Warning Snackbar
    static warningSnackBar({required title, message  = ''}) {
        Get.snackbar(title, message,
            isDismissible: true,
            shouldIconPulse: true,
            colorText: UColors.white,
            backgroundColor: Colors.yellow.shade900,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3),
            margin: const EdgeInsets.all(20),
            icon: Icon(Iconsax.warning_2, color: UColors.white)
        );
    }

   // Success Snackbar
    static successSnackBar({required title, message  = ''}) {
      Get.snackbar(title, message,
          isDismissible: true,
          shouldIconPulse: true,
          colorText: UColors.white,
          backgroundColor: UColors.primary,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(20),
          icon: Icon(Iconsax.check, color: UColors.white)
      );
    }

    // Error Red SnackBar
    static ErrorSnackBar({required title, message  = ''}) {
      Get.snackbar(title, message,
          isDismissible: true,
          shouldIconPulse: true,
          colorText: UColors.white,
          backgroundColor: Colors.red.shade400,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(20),
          icon: Icon(Iconsax.warning_2, color: UColors.white)
      );
    }

    // Custome Snackbar
    static void customToast({String message = '', Color bg = UColors.primary}) {
      Get.rawSnackbar(
        messageText: Text(
          message,
          style: TextStyle(color: UColors.white),
        ),
        backgroundColor: bg,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(20),
        borderRadius: 8,
        duration: const Duration(seconds: 3),
        isDismissible: true,
      );
    }

}