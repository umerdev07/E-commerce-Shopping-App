import 'package:e_commerce/common/widgets/shimmer/brands_shimmer.dart';
import 'package:e_commerce/common/widgets/shimmer/shimmer_effect.dart';
import 'package:e_commerce/common/widgets/shimmer/verical_product_shimmer.dart';
import 'package:e_commerce/features/shop/controllers/home/home_controller.dart';
import 'package:e_commerce/features/shop/controllers/product/product_controller.dart';
import 'package:e_commerce/features/shop/models/product_model.dart';
import 'package:e_commerce/features/shop/screens/all_products/all_products.dart';
import 'package:e_commerce/features/shop/screens/home/widgets/home_app_bar.dart';
import 'package:e_commerce/features/shop/screens/home/widgets/home_category.dart';
import 'package:e_commerce/features/shop/screens/home/widgets/home_promo_slider.dart';
import 'package:e_commerce/utils/constants/texts.dart';
import 'package:e_commerce/utils/constants/uimages.dart';
import 'package:e_commerce/utils/helpers/device_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/header/primart_header_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/card/product_card_vertical.dart';
import '../../../../common/widgets/textFields/search_bar.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    final productController = Get.put(ProductController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: UDeviceHelper.getScreenHeight(context) * 0.365,
                ),

                /// --------- [UPPER PART] -----------
                UPrimaryHeaderContainer(
                  height: UDeviceHelper.getScreenHeight(context) * 0.365,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UHomeAppBar(),
                      SizedBox(height: USizes.spaceBtwSections),

                      // Popular Categories
                      UHomeCategories(),
                    ],
                  ),
                ),
                // Search Bar
                searchBar(),
              ],
            ),

            /// ----------- [LOWER PART]--------------

            // Banner & Products card
            Padding(
              padding: const EdgeInsets.all(USizes.defaultSpace),
              child: Column(
                children: [
                  UPromoSlider(banner: []),

                  SizedBox(height: USizes.spaceBtwSections / 2),

                  // Section Headings
                  SectionHeading(
                    sectionHeading: UTexts.popularProducts,
                    onTap: () => Get.to(() => AllProductsScreen(title: 'Popular Products', futureMethod: productController.getAllFeaturedProducts())),
                  ),

                  const SizedBox(height: USizes.spaceBtwItems),

                  // Vertical Products Card
                  Obx(() {
                    if (productController.isProductLoading.value) {
                      return Center(child: UVerticalProductShimmer());
                    }

                    if (productController.featuredProducts.isEmpty) {
                      return Center(child: Text('Product not found!'));
                    }

                    return UGridLayout(
                      itemCount: productController.featuredProducts.length,
                      itemBuilder: (BuildContext context, int index) {
                        ProductModel productModel =
                            productController.featuredProducts[index];
                        return UProductCardVertical(product: productModel);
                      },
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
