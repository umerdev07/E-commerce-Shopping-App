import 'package:e_commerce/common/widgets/shimmer/category_shimmer.dart';
import 'package:e_commerce/common/widgets/shimmer/shimmer_effect.dart';
import 'package:e_commerce/features/shop/controllers/category/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/image_text/vertical_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';
import 'package:e_commerce/utils/constants/uimages.dart';

import '../../../models/category_model.dart';
import '../../sub_category/sub_category.dart';

class UHomeCategories extends StatelessWidget {
  const UHomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());

    return Padding(
      padding: const EdgeInsets.only(left: USizes.spaceBtwSections),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Title
          Text(
            UTexts.homeCategoryTitle,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.apply(color: UColors.white),
          ),

          SizedBox(height: USizes.spaceBtwItems),

          // Category ListView
          Obx(() {

            final categories = controller.isFeaturedCategory;

            // Category Loader
            if(controller.isCategoryLoading.value){
              return UCategoryShimmer(itemCount: 6);
            }

            // Category Found
            return SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  CategoryModel category = categories[index];
                  return UVericalImageText(
                    categoryTitle: category.name,
                    categoryImage: category.image,
                    textColor: UColors.white,
                    onTap: () => Get.to(() => SubCategoryScreen(category: category)),
                   );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(width: USizes.spaceBtwItems);
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
