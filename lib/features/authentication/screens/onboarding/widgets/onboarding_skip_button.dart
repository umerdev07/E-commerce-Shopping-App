import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/helpers/device_helper.dart';
import '../../../controllers/onBoarding/onboarding_controller.dart';

class onBoardingSkipButton extends StatelessWidget {
  const onBoardingSkipButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.instance;
    return Obx(
      () => controller.currentPage.value == 2
          ? SizedBox()
          : Positioned(
              top: UDeviceHelper.getAppBarHeight(),
              right: 0,
              child: TextButton(
                onPressed: controller.skipPage,
                child: Text('Skip'),
              ),
            ),
    );
  }
}
