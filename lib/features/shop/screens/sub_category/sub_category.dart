import 'package:e_commerce/common/styles/u_padding.dart';
import 'package:e_commerce/common/widgets/shimmer/horizontal_product_shimmer.dart';
import 'package:e_commerce/common/widgets/shimmer/verical_product_shimmer.dart';
import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/shop/controllers/category/category_controller.dart';
import 'package:e_commerce/features/shop/models/category_model.dart';
import 'package:e_commerce/features/shop/models/product_model.dart';
import 'package:e_commerce/features/shop/screens/all_products/all_products.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/products/card/product_card_horizontal.dart';
import '../../../../utils/helpers/helper_function.dart';

class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({super.key, required this.category});

  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    UHelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          category.name,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              // Fetch SubCatgories for SubCategory
              FutureBuilder(
                future: controller.getProductSubcategory(category.id),
                builder: (context, snapshot) {
                  final loader = UHorizontalProductShimmer();
                  Widget? widget = UCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot,
                    loader: loader,
                  );

                  if (widget != null) return widget;

                  List<CategoryModel> subCategory = snapshot.data!;

                  return ListView.builder(
                    itemCount: subCategory.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      CategoryModel subCategories = subCategory[index];

                      // Fetch Products for Subcategory
                      return FutureBuilder(
                        future: controller.getProductCategories(
                          categoryId: subCategories.id,
                        ),
                        builder: (context, snapshot) {
                          // Handle State
                          Widget? widget =
                              UCloudHelperFunctions.checkMultiRecordState(
                                snapshot: snapshot,loader: loader
                              );
                          if (widget != null) return widget;

                          List<ProductModel> products = snapshot.data!;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SectionHeading(
                                sectionHeading: subCategories.name,
                                onTap: () => Get.to(
                                  () => AllProductsScreen(
                                    title: subCategories.name,
                                    futureMethod: controller
                                        .getProductCategories(
                                          categoryId: subCategories.id,
                                          limit: -1,
                                        ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: USizes.spaceBtwItems),

                              SizedBox(
                                height: 120,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: products.length,
                                  itemBuilder: (context, index) {
                                    ProductModel product = products[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 12),
                                      child: UHorizontalProductCard(
                                        product: product,
                                      ),
                                    );
                                  },
                                ),
                              ),

                              const SizedBox(height: USizes.spaceBtwItems),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
