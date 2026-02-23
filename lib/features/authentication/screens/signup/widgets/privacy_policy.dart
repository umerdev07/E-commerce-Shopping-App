import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/texts.dart';
import '../../../../../utils/helpers/helper_function.dart';
import '../../../controllers/signUp/signup_controller.dart';

class privacyPolicy extends StatelessWidget {
  const privacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunction.isDarkMode(context);
    final controller = SignupController.instance;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Obx(
          () => Checkbox(
            value: controller.privacyPolicy.value,
            onChanged: (value) => controller.privacyPolicy.value =
                !controller.privacyPolicy.value,
          ),
        ),
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            children: [
              TextSpan(text: '${UTexts.iAgreeTo} '),
              TextSpan(
                text: '${UTexts.isPrivacy} ',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: dark ? UColors.white : UColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: dark ? UColors.white : UColors.primary,
                ),
              ),
              TextSpan(text: '${UTexts.and} '),
              TextSpan(
                text: '${UTexts.termsOfUse} ',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: dark ? UColors.white : UColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: dark ? UColors.white : UColors.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
