import 'package:e_commerce/features/shop/controllers/banner/banner_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../utils/helpers/device_helper.dart';
import '../../../controllers/home/home_controller.dart';

class homeBannerDotNavigation extends StatelessWidget {
  const homeBannerDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
    final bannerController = Get.put(BannerController());

    return Positioned(
      bottom: UDeviceHelper.getBottomNavigationBarHeight() * 4,
      left: UDeviceHelper.getScreenWidth(context) / 3,
      right: UDeviceHelper.getScreenWidth(context) / 3,

      child: Obx(
        () => SmoothPageIndicator(
          count: bannerController.allBanners.length,
          effect: ExpandingDotsEffect(dotHeight: 6.0),
          controller: PageController(initialPage: controller.currentBanner.value),
          onDotClicked: controller.onDotIndicator,
        ),
      ),
    );
  }
}
