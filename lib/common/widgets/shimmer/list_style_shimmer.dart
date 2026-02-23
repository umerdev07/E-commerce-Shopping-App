import 'package:e_commerce/common/widgets/shimmer/shimmer_effect.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class UListStyleShimmer extends StatelessWidget {
  const UListStyleShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            // Brand Logo
            UShimmerEffect(width: 50, height: 50, radius: 50),
            SizedBox(height:  USizes.spaceBtwItems),
            Column(
              children: [
                // Brand Name
                UShimmerEffect(width: 100, height: 15),
                SizedBox(height: USizes.spaceBtwItems / 2),

                // Brand Product
                UShimmerEffect(width: 100, height: 12),

              ],
            )
          ],
        )
      ],
    );
  }
}
