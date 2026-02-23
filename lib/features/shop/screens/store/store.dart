import 'package:e_commerce/common/widgets/shimmer/brands_shimmer.dart';
import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/shop/controllers/brand/brand_controller.dart';
import 'package:e_commerce/features/shop/controllers/category/category_controller.dart';
import 'package:e_commerce/features/shop/screens/store/widgets/categoryTab.dart';
import 'package:e_commerce/features/shop/screens/store/widgets/store_primary_header.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appbar/tabbar.dart';
import '../../../../common/widgets/brands/brand_card.dart';
import '../brands/all_brands.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = CategoryController.instance;
    final brandController = Get.put(BrandController());
    final bool dark = UHelperFunction.isDarkMode(context);

    return Scaffold(
      body: DefaultTabController(
        length: categoryController.isFeaturedCategory.length,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: 340,
                pinned: true,
                floating: false,
                flexibleSpace: SingleChildScrollView(
                  child: Column(
                    children: [
                      /// Primary Header
                      UStorePrimaryHeader(),

                      SizedBox(height: USizes.spaceBtwItems),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: USizes.defaultSpace,
                        ),
                        child: Column(
                          children: [
                            /// Brand Heading
                            SectionHeading(
                              sectionHeading: 'Brands',
                              onTap: () => Get.to(() => AllBrandsScreen()),
                            ),

                            /// Brand Cards
                            SizedBox(
                              height: 70.0,
                              child: Obx(() {

                                // Loading state
                                if (brandController.isBrandLoading.value) {
                                  return UBrandShimmer();
                                }

                                // Empty state
                                if (brandController.isFeature.isEmpty) {
                                  return const Center(
                                    child: Text('No Brands Found'),
                                  );
                                }

                                // Brand list
                                return ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      SizedBox(width: USizes.spaceBtwItems),
                                  shrinkWrap: true,
                                  itemCount: brandController.isFeature.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    final brand = brandController.isFeature[index];

                                    return SizedBox(
                                      width: USizes.brandCardWidth,
                                      child: UBrandCard(brandModel: brand),
                                    );
                                  },
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                bottom: UTabBar(
                  tabs: categoryController.isFeaturedCategory
                      .map((category) => Tab(child: Text(category.name)))
                      .toList(),
                ),
              ),
            ];
          },

          body: TabBarView(
            children: categoryController.isFeaturedCategory
                .map((category) => UCategoryTabs(categoryModel: category))
                .toList(),
          ),
        ),
      ),
    );
  }
}
