import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/uimages.dart';
import '../../../../utils/helpers/helper_function.dart';
import '../../images/rounded__image.dart';
import '../../texts/brand_title_with_verify_icon.dart';
import '../../texts/product_title_text.dart';

class UCartItem extends StatelessWidget {
  const UCartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool dark = UHelperFunction.isDarkMode(context);
    return Row(
      children: [
        URoundedImage(
          imageUrl: UImages.productImage1,
          width: 60,
          height: 60,
          padding: EdgeInsets.all(USizes.sm),
          backgroundColor: dark ? UColors.darkerGrey : UColors.light,
        ),

        SizedBox(width: USizes.spaceBtwItems),

        Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UBrandTitleWitVerifyIcon(title: 'Bata'),
                UProductTitleText(title: 'Blue Berry Shoes Medium Size', maxLine: 1),

                RichText(text: TextSpan(children: [
                  TextSpan(text: "Color ", style: Theme.of(context).textTheme.bodySmall),
                  TextSpan(text: "Blue ", style: Theme.of(context).textTheme.bodyLarge),
                  TextSpan(text: "Size ", style: Theme.of(context).textTheme.bodySmall),
                  TextSpan(text: "Medium", style: Theme.of(context).textTheme.bodyLarge)
                ]))
              ],
            )
        )
      ],
    );
  }
}
