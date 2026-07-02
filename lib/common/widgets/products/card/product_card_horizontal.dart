import 'package:e_commerce/common/widgets/favourite/u_favourite.dart';
import 'package:e_commerce/common/widgets/texts/product_title_text.dart';
import 'package:e_commerce/features/shop/models/product_model.dart';
import 'package:e_commerce/features/shop/screens/product_details/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../features/shop/controllers/product/product_controller.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_function.dart';

import '../../button/add_to_cart_button.dart';
import '../../custom_shapes/URoundedContainer.dart';
import '../../images/rounded__image.dart';
import '../../texts/brand_title_with_verify_icon.dart';
import '../../texts/product_price.dart';

class UHorizontalProductCard extends StatelessWidget {
  const UHorizontalProductCard({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final bool dark = UHelperFunction.isDarkMode(context);
    final controller = ProductController.instance;
    String? salePercentage = controller.calculateSalesPercentage(
      product.price,
      product.salesPrice,
    );
    return GestureDetector(
        onTap: () => Get.to(() => UProductDetailScreen(product: product)),
      child: Container(
        width: 294,
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(USizes.productImageRadius),
          color: dark ? UColors.darkerGrey : UColors.white,
        ),
        child: Row(
          children: [
            // Left-Portion
            URoundedContainer(
              width: 120,
              padding: EdgeInsets.all(USizes.sm),
              backgroundColor: dark ? UColors.dark : UColors.light,
              child: Stack(
                children: [
                  URoundedImage(imageUrl: product.thumbnail, isNetworkImage: true),

                  // Discount Tag
                  if(salePercentage != null)
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
                        style: Theme.of(
                          context,
                        ).textTheme.labelLarge!.copyWith(color: UColors.black),
                      ),
                    ),
                  ),

                  // Favourite Button
                  Positioned(
                    right: 0,
                    top: 0,
                    child: UFavouriteIcon(productId: product.id),
                  ),
                ],
              ),
            ),

            // Right-Portion
            SizedBox(
              width: 172.0,
              child: Padding(
                padding: const EdgeInsets.only(left: USizes.sm, top: USizes.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UProductTitleText(
                          title: product.title,
                          smallSize: true,
                        ),
                        SizedBox(height: USizes.spaceBtwItems / 2),
                        UBrandTitleWitVerifyIcon(title: product.brand?.name ?? 'No Brand'),
                      ],
                    ),
                    Spacer(),
                    // Product Price $ Add Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(child: UProductCadPrice(productPrice: controller.calculateAndGetProductPrice(product))),

                        UProductAddToCartButton(product: product)

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
