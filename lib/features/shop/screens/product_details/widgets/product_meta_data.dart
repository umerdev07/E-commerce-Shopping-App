import 'package:e_commerce/features/shop/controllers/product/product_controller.dart';
import 'package:e_commerce/features/shop/models/product_model.dart';
import 'package:e_commerce/utils/constants/enum.dart';
import 'package:e_commerce/utils/constants/texts.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/custom_shapes/URoundedContainer.dart';
import '../../../../../common/widgets/images/circular_image.dart';
import '../../../../../common/widgets/texts/brand_title_with_verify_icon.dart';
import '../../../../../common/widgets/texts/product_price.dart';
import '../../../../../common/widgets/texts/product_title_text.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class UProductMetaData extends StatelessWidget {
  const UProductMetaData({
    super.key, required this.product,
  });
   final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    String? salesPrice = controller.calculateSalesPercentage(product.price, product.salesPrice);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Sale Tag, Sale Price, Actual Price and Share Icon
        Row(
          children: [
            // Sale Tag
            if(salesPrice!=null && salesPrice.isNotEmpty)...[
              URoundedContainer(
                radius: USizes.sm,
                backgroundColor: UColors.yellow.withValues(alpha: 0.8),
                padding: const EdgeInsets.symmetric(
                  horizontal: USizes.sm,
                  vertical: USizes.xs,
                ),
                child: Text(
                  '$salesPrice%',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(color: UColors.black),
                ),
              ),
              SizedBox(width: USizes.spaceBtwItems),
            ],

            // Actual Price
            if(product.productType == ProductType.single.toString() && product.salesPrice > 0)...[
              Text('${UTexts.currency}${product.price.toStringAsFixed(0)}', style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough)),

              SizedBox(width: USizes.spaceBtwItems),

            ],

            // Sale or Actual Price
            UProductCadPrice(productPrice: controller.calculateAndGetProductPrice(product), isLarge: true),

            Spacer(),

            // Share Icon Button
            IconButton(onPressed: () {}, icon: Icon(Icons.share)),


          ],
        ),
        SizedBox(height: USizes.spaceBtwItems / 1.5),

        /// Product Title
        UProductTitleText(title: product.title),
        SizedBox(height: USizes.spaceBtwItems / 1.5),

        /// Product Status
        Row(
          children: [
            UProductTitleText(title: 'Status: '),
            SizedBox(width: USizes.spaceBtwItems),
            Text(controller.getProductStock(product.stock), style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        SizedBox(height: USizes.spaceBtwItems / 1.5),

        Row(
          children: [

            // Brand Image
            UCircularImage(
                padding: 0,
                isNetworkImage: true,
                image: product.brand != null ? product.brand!.image : '', width: 32.0, height: 32.0),
            SizedBox(width: USizes.spaceBtwItems),

            // Brand Title
            UBrandTitleWitVerifyIcon(title: product.brand != null ? product.brand!.name : ''),
          ],
        )
      ],
    );
  }
}