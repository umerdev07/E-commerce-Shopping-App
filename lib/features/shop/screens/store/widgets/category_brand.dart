import 'package:e_commerce/common/widgets/shimmer/boxes_shimmer.dart';
import 'package:e_commerce/common/widgets/shimmer/list_style_shimmer.dart';
import 'package:e_commerce/common/widgets/shimmer/shimmer_effect.dart';
import 'package:e_commerce/features/shop/controllers/brand/brand_controller.dart';
import 'package:e_commerce/features/shop/models/category_model.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/uimages.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_function.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../../common/widgets/brands/brand_showcase.dart';

class CategoryBrand extends StatelessWidget {
  const CategoryBrand({super.key, required this.category});

  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    final dark = UHelperFunction.isDarkMode(context);
    return FutureBuilder(
      future: controller.getBrandCategories(category.id),
      builder: (context, snapshot) {
        
        final loader = Column(
          children: [
            UListStyleShimmer(),
            SizedBox(height: USizes.spaceBtwItems),
            UBoxesShimmer(),
            SizedBox(height: USizes.spaceBtwItems),

          ],
        );

        Widget? widget = UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);

        if(widget != null) return widget;

        final brands = snapshot.data!;

        // Records Found
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
            itemCount: brands.length,
            itemBuilder: (context, index) {
              final brand = brands[index];
              return FutureBuilder(
                  future: controller.getSpecificBrandProducts(brand.id, limit: 3),
                  builder: (context, snapshot) {

                    Widget? widget = UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                    if(widget != null) return widget;

                    final product = snapshot.data!;

                    return UBrandShowCase(
                      brand: brand,
                      dark: dark,
                      images: product.map((product) => product.thumbnail).toList(),
                    );
                  },
              );
            }
        );
      }
    );
    
  }
}
