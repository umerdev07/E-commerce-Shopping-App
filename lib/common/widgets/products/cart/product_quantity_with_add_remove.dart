import 'package:e_commerce/features/shop/controllers/cart/cart_controller.dart';
import 'package:e_commerce/features/shop/models/cart_item_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../icons/circular_icon.dart';

class UProductQuantityWithAddRemove extends StatelessWidget {
  const UProductQuantityWithAddRemove({
    super.key,
    required this.dark, required this.quantity, this.add, this.remove,
  });

  final bool dark;
  final int quantity;
  final VoidCallback? add, remove;

  @override
  Widget build(BuildContext context) {
    return
     Row(
        children: [
          //Decrement Button
          UCircularIcon(
            icon: Icons.remove,
            backgroundColor: dark
                ? UColors.darkerGrey
                : UColors.light,
            size: USizes.iconSm,
            width: 32.0,
            height: 32.0,
            color: dark ? UColors.white : UColors.black,
            onPressed: remove,
          ),
          SizedBox(width: USizes.spaceBtwItems),

          // Counter
          Text(
            quantity.toString(),
            style: Theme.of(context).textTheme.titleSmall,
          ),
          SizedBox(width: USizes.spaceBtwItems),

          // Increment
          UCircularIcon(
            icon: Icons.add,
            backgroundColor: UColors.primary,
            size: USizes.iconSm,
            width: 32.0,
            height: 32.0,
            color: UColors.white,
            onPressed: add,
          ),

        ],
    );
  }
}
