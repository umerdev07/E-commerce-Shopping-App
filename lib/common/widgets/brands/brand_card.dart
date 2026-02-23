import 'package:e_commerce/features/shop/models/brand_model.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/enum.dart';
import '../../../utils/constants/sizes.dart';
import '../custom_shapes/URoundedContainer.dart';
import '../images/rounded__image.dart';
import '../texts/brand_title_with_verify_icon.dart';

class UBrandCard extends StatelessWidget {
  const UBrandCard({
    super.key,
    this.showBorder = true,
    this.overflow = TextOverflow.ellipsis,
    this.onTap,
    this.width = 170.0,
    required this.brandModel
  });

  final TextOverflow overflow;
  final bool showBorder;
  final VoidCallback? onTap;
  final double? width;

  final BrandModel brandModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: URoundedContainer(
        width: width,
        height: 70.0,
        showBorder: showBorder,
        padding: EdgeInsets.all(USizes.sm),
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            /// Brand Image
            Flexible(
              child: URoundedImage(
                imageUrl: brandModel.image,
                isNetworkImage: true,
                backgroundColor: Colors.transparent,
              ),
            ),
            SizedBox(width: USizes.spaceBtwItems / 2),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Brand Name & verify Icon
                  UBrandTitleWitVerifyIcon(
                    title: brandModel.name,
                    brandTextSize: TextSizes.large,
                  ),
                  Text(
                    '${brandModel.productCount} products',
                    style: Theme.of(context).textTheme.labelMedium,
                    overflow: overflow,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
