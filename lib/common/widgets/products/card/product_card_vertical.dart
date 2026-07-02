import 'package:e_commerce/common/widgets/button/add_to_cart_button.dart';
import 'package:e_commerce/common/widgets/custom_shapes/URoundedContainer.dart';
import 'package:e_commerce/common/widgets/favourite/u_favourite.dart';
import 'package:e_commerce/common/widgets/images/rounded__image.dart';
import 'package:e_commerce/features/shop/controllers/product/product_controller.dart';
import 'package:e_commerce/features/shop/models/product_model.dart';
import 'package:e_commerce/features/shop/screens/product_details/product_detail.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/uimages.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../styles/u_shadow.dart';
import '../../icons/circular_icon.dart';
import '../../texts/brand_title_with_verify_icon.dart';
import '../../texts/product_price.dart';
import '../../texts/product_title_text.dart';

class UProductCardVertical extends StatelessWidget {
  const UProductCardVertical({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    bool dark = UHelperFunction.isDarkMode(context);
    final controller = ProductController.instance;
    String? salePercentage = controller.calculateSalesPercentage(
      product.price,
      product.salesPrice,
    );

    return GestureDetector(
      onTap: () => Get.to(() => UProductDetailScreen(product: product)),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: UShadow.vericalProductShadow,
          borderRadius: BorderRadius.circular(USizes.productImageRadius),
          color: dark ? UColors.darkerGrey : UColors.light,
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail, favourite and discount
            URoundedContainer(
              height: 150,
              padding: const EdgeInsets.all(USizes.sm),
              backgroundColor: dark ? UColors.dark : UColors.white,
              child: Stack(
                children: [
                  // Thumbnail
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: URoundedImage(
                        imageUrl: product.thumbnail,
                        isNetworkImage: true,
                        applyImageRadius: false,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  // Discount Tag
                  if (salePercentage != null)
                    Positioned(
                      top: 12.0,
                      child: URoundedContainer(
                        radius: USizes.sm,
                        backgroundColor: UColors.yellow.withValues(alpha: 0.8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: USizes.sm,
                          vertical: USizes.xs,
                        ),
                        child: Text(
                          '$salePercentage%',
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(color: UColors.black),
                        ),
                      ),
                    ),

                  // Favourite Button
                  Positioned(
                    right: 0,
                    top: 0,
                    child: UFavouriteIcon(productId: product.id)
                  ),
                ],
              ),
            ),
            SizedBox(height: USizes.spaceBtwItems / 2),

            // Details
            Padding(
              padding: const EdgeInsets.only(left: USizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Title
                  UProductTitleText(title: product.title, smallSize: true),
                  SizedBox(height: USizes.spaceBtwItems / 2),

                  // Product Brand
                  UBrandTitleWitVerifyIcon(
                    title: product.brand?.name ?? 'No Brand',
                  ),
                ],
              ),
            ),

            Spacer(),

            // Product Price $ Add Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UProductCadPrice(
                  productPrice: controller.calculateAndGetProductPrice(product),
                ),

                // Add Button
                UProductAddToCartButton(product: product)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
