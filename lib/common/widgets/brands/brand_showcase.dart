import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/common/widgets/shimmer/shimmer_effect.dart';
import 'package:e_commerce/features/shop/models/brand_model.dart';
import 'package:e_commerce/features/shop/screens/brands/brand_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../custom_shapes/URoundedContainer.dart';
import 'brand_card.dart';

class UBrandShowCase extends StatelessWidget {
  const UBrandShowCase({
    super.key,
    required this.dark,
    required this.images,
    required this.brand,
  });

  final bool dark;
  final List<String> images;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => BrandProductsScreen(title: brand.name, brand: brand)),
      child: URoundedContainer(
        showBorder: true,
        borderColor: UColors.darkGrey,
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.all(USizes.md),
        margin: EdgeInsets.only(bottom: USizes.spaceBtwItems),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UBrandCard(showBorder: false, brandModel: brand),
            Row(
              children: images.map((images) => buildBrandImage(images)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBrandImage(String images) {
    return Expanded(
      child: URoundedContainer(
        height: 100,
        padding: EdgeInsets.only(right: USizes.sm),
        margin: EdgeInsets.all(USizes.md),
        backgroundColor: dark ? UColors.darkGrey : UColors.light,
        child: CachedNetworkImage(
          imageUrl: images,
          fit: BoxFit.contain,
          progressIndicatorBuilder: (context, url, progress) =>
              UShimmerEffect(width: 100, height: 100),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}
