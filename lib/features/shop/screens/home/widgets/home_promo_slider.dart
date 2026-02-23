import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/common/widgets/shimmer/shimmer_effect.dart';
import 'package:e_commerce/features/shop/controllers/banner/banner_controller.dart';
import 'package:e_commerce/features/shop/controllers/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/images/rounded__image.dart';
import '../../../../../utils/constants/sizes.dart';
import 'home_banners.dart';

class UPromoSlider extends StatelessWidget {
  const UPromoSlider({super.key, required this.banner});

  final List<String> banner;

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
    final bannerController = Get.put(BannerController());
    return Obx(() {
      if (bannerController.isBannerLoading.value) {
        return UShimmerEffect(width: double.infinity, height: 190);
      }

      if (bannerController.allBanners.isEmpty) {
        return Text('Banner not found');
      }
      return Column(
        children: [
          CarouselSlider(
            items: bannerController.allBanners
                .map(
                  (banner) => URoundedImage(
                    imageUrl: banner.imageUrl,
                    isNetworkImage: true,
                    onPressed: () => Get.toNamed(banner.targetScreen),
                  ),
                )
                .toList(),
            options: CarouselOptions(
              viewportFraction: 1.0,
              onPageChanged: (index, reason) => controller.onPageChange(index),
            ),
            carouselController: controller.carouselController,
          ),
          SizedBox(height: USizes.spaceBtwSections),
          homeBannerDotNavigation(),
        ],
      );
    });
  }
}
