import 'package:e_commerce/common/widgets/icons/circular_icon.dart';
import 'package:e_commerce/features/shop/controllers/cart/cart_controller.dart';
import 'package:e_commerce/features/shop/models/product_model.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class UBottomAddToCart extends StatelessWidget {

  final ProductModel product;

  const UBottomAddToCart({super.key, required this.product});



  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    final bool dark = UHelperFunction.isDarkMode(context);

    controller.updateAlreadyUpdateProductCount(product);
    return Container(

      padding: const EdgeInsets.symmetric(horizontal: USizes.defaultSpace, vertical: USizes.defaultSpace / 2),
      decoration: BoxDecoration(
        color: dark ? UColors.darkerGrey : UColors.light,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(USizes.cardRadiusLg),
          topRight: Radius.circular(USizes.cardRadiusLg),
        )

      ),

      child: Obx( () => Row(
          children: [

            // Decrement Button
            UCircularIcon(
              icon: Icons.remove,
              backgroundColor: UColors.grey,
              width: 40.0,
              height: 40.0,
              color: UColors.white,
              onPressed:  controller.productQuantityInCart.value < 1 ? null : () => controller.productQuantityInCart.value -= 1
            ),
            SizedBox(width: USizes.spaceBtwItems),

            // Counter
            Text(controller.productQuantityInCart.value.toString(), style: Theme.of(context).textTheme.titleSmall),
            SizedBox(width: USizes.spaceBtwItems),

            //Increment Button
            UCircularIcon(
              icon: Icons.add,
              backgroundColor: Colors.black,
              width: 40.0,
              height: 40.0,
              color: UColors.white,
              onPressed: () => controller.productQuantityInCart.value += 1,
            ),

            Spacer(),

            // Add to Card Button
            ElevatedButton(
              onPressed: () => controller.productQuantityInCart.value < 1 ? null : controller.addToCart(product),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(USizes.md),
                backgroundColor: UColors.black,
                side: BorderSide(color: UColors.black),

              ),
              child: Row(
                children: [
                  Icon(Iconsax.shopping_bag),
                  SizedBox(width: USizes.spaceBtwItems / 2),
                  Text('Add to Cart'),
                ],
              )
            )

          ],
        ),
      ),
    );
  }
}
