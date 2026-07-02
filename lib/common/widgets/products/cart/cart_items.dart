import 'package:e_commerce/features/shop/controllers/cart/cart_controller.dart';
import 'package:e_commerce/features/shop/models/cart_item_model.dart';
import 'package:e_commerce/features/shop/models/product_model.dart';
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
    super.key, required this.cartItemModel,
  });

  final CartItemModel cartItemModel;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    final bool dark = UHelperFunction.isDarkMode(context);
    return Row(
      children: [
        URoundedImage(
          imageUrl: cartItemModel.image ?? '',
          width: 60,
          height: 60,
          isNetworkImage: true,
          padding: EdgeInsets.all(USizes.sm),
          backgroundColor: dark ? UColors.darkerGrey : UColors.light,
        ),

        SizedBox(width: USizes.spaceBtwItems),

        Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UBrandTitleWitVerifyIcon(title: cartItemModel.brandName ?? ''),
                UProductTitleText(title: cartItemModel.title, maxLine: 1),

                RichText(text: TextSpan(children: (cartItemModel.selectedVariation ?? {}).entries.map((e) => TextSpan(
                  children: [
                    TextSpan(text: e.key, style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(text: '${e.value}', style: Theme.of(context).textTheme.bodyLarge),
                  ]
                )).toList()
                ))
              ],
            )
        )
      ],
    );
  }
}
