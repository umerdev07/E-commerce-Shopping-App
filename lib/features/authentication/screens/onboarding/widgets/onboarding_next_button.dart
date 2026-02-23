import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/button/u_elevatedbutton.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/onBoarding/onboarding_controller.dart';

class onBoardingNextButton extends StatelessWidget {
  const onBoardingNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.instance;
    return Positioned(
      left: 0,
      right: 0,
      bottom: USizes.defaultSpace,
      child: UElevatedButton(
        onPressed: controller.nextPage,
        child: Obx(
          () =>
              Text(controller.currentPage.value == 2 ? 'Get Started'  : 'Next'),
        ),
      ),
    );
  }
}
