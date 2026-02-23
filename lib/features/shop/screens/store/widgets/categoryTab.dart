import 'package:e_commerce/common/widgets/shimmer/verical_product_shimmer.dart';
import 'package:e_commerce/features/shop/controllers/category/category_controller.dart';
import 'package:e_commerce/features/shop/models/category_model.dart';
import 'package:e_commerce/features/shop/screens/all_products/all_products.dart';
import 'package:e_commerce/features/shop/screens/store/widgets/category_brand.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../common/widgets/products/card/product_card_vertical.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../models/product_model.dart';

class UCategoryTabs extends StatelessWidget {
  const UCategoryTabs({super.key, required this.categoryModel});

  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: USizes.defaultSpace),
          child: Column(
            children: [
              CategoryBrand(category: categoryModel),
              SizedBox(height: USizes.spaceBtwItems),
              SectionHeading(
                sectionHeading: 'You might like',
                onTap: () =>
                    Get.to(() => AllProductsScreen(
                      title: categoryModel.name,
                      futureMethod: controller.getProductCategories(categoryId: categoryModel.id, limit: -1),
                    )),
              ),
              FutureBuilder(
                  future: controller.getProductCategories(categoryId: categoryModel.id),
                  builder: (context, snapshot) {

                    final loader = UVerticalProductShimmer(itemCount: 4);

                    final widget = UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);

                    if(widget != null) return widget;

                    List<ProductModel> products = snapshot.data!;
                    return UGridLayout(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        ProductModel product = products[index];
                        return UProductCardVertical(product: product);
                      },
                    );
                  },
              ),
              SizedBox(height: USizes.spaceBtwSections),
            ],
          ),
        ),
      ],
    );
  }
}
