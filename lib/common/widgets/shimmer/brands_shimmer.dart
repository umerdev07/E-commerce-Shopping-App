import 'package:e_commerce/common/widgets/shimmer/shimmer_effect.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';

class UBrandShimmer extends StatelessWidget{

  UBrandShimmer({
    super.key,
    this.itemCount = 4,
});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) => SizedBox(width: USizes.spaceBtwItems),
        itemCount: itemCount,
      itemBuilder:  (context, index) => const UShimmerEffect(width: USizes.brandCardWidth, height: USizes.brandCardHeight)
    );
  }
  
}