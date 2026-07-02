import 'package:e_commerce/features/shop/controllers/cart/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

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
    final controller = CartController.instance;

    return Obx(() => ListView.separated(
      shrinkWrap: true,
      physics: neverScrollable
          ? const NeverScrollableScrollPhysics()
          : const BouncingScrollPhysics(),
      separatorBuilder: (context, index) =>
          SizedBox(height: USizes.spaceBtwSections),
      itemCount: controller.cartItem.length,
      itemBuilder: (context, index) {
        final cartItem = controller.cartItem[index];

        return Column(
          children: [
            UCartItem(cartItemModel: cartItem),

            if (showAddRemoveButtons)
              SizedBox(height: USizes.spaceBtwItems),

            if (showAddRemoveButtons)
              Row(
                children: [
                  SizedBox(width: 70.0),

                  UProductQuantityWithAddRemove(
                    dark: dark,
                    quantity: cartItem.quantity,
                    add: () => controller.addOneToCart(cartItem),
                    remove: () =>
                        controller.removeOneFromCart(cartItem),
                  ),

                  Spacer(),

                  UProductCadPrice(
                    productPrice:
                    (cartItem.price * cartItem.quantity)
                        .toStringAsFixed(0),
                  ),
                ],
              ),
          ],
        );
      },
    ));
  }
}
