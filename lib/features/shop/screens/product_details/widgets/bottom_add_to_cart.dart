import 'package:e_commerce/common/widgets/icons/circular_icon.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class UBottomAddToCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool dark = UHelperFunction.isDarkMode(context);
    return Container(

      padding: const EdgeInsets.symmetric(horizontal: USizes.defaultSpace, vertical: USizes.defaultSpace / 2),
      decoration: BoxDecoration(
        color: dark ? UColors.darkerGrey : UColors.light,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(USizes.cardRadiusLg),
          topRight: Radius.circular(USizes.cardRadiusLg),
        )

      ),

      child: Row(
        children: [

          // Decrement Button
          UCircularIcon(
            icon: Icons.remove,
            backgroundColor: UColors.grey,
            width: 40.0,
            height: 40.0,
            color: UColors.white,
          ),
          SizedBox(width: USizes.spaceBtwItems),

          // Counter
          Text('2', style: Theme.of(context).textTheme.titleSmall),
          SizedBox(width: USizes.spaceBtwItems),

          //Increment Button
          UCircularIcon(
            icon: Icons.add,
            backgroundColor: Colors.black,
            width: 40.0,
            height: 40.0,
            color: UColors.white,
          ),

          Spacer(),

          // Add to Card Button
          ElevatedButton(
            onPressed: () {},
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
    );
  }
}
