import 'package:flutter/material.dart';

import '../../../../../common/widgets/products/cart/cart_items.dart';
import '../../../../../common/widgets/products/cart/product_quantity_with_add_remove.dart';
import '../../../../../common/widgets/texts/product_price.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_function.dart';

class UCartItems extends StatelessWidget {
  const UCartItems({
    super.key,
    this.showAddRemoveButtons = true,
    this.neverScrollable = false,
  });

  final bool showAddRemoveButtons;
  final bool neverScrollable;

  @override
  Widget build(BuildContext context) {
    final bool dark = UHelperFunction.isDarkMode(context);

    return ListView.separated(
      shrinkWrap: true,
      physics: neverScrollable
          ? const NeverScrollableScrollPhysics()
          : const BouncingScrollPhysics(),

      separatorBuilder: (context, index) =>
          SizedBox(height: USizes.spaceBtwSections),

      itemCount: 4,
      itemBuilder: (context, index) {
        return Column(
          children: [

            // Cart Item
            UCartItem(),

            if (showAddRemoveButtons)
              SizedBox(height: USizes.spaceBtwItems),

            // Price + Counter
            if (showAddRemoveButtons)
              Row(
                children: [
                  SizedBox(width: 70.0),
                  UProductQuantityWithAddRemove(dark: dark),

                  Spacer(),

                  UProductCadPrice(productPrice: '150'),
                ],
              ),
          ],
        );
      },
    );
  }
}
