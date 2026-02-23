import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../icons/circular_icon.dart';

class UProductQuantityWithAddRemove extends StatelessWidget {
  const UProductQuantityWithAddRemove({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //Increment Button
        UCircularIcon(
          icon: Icons.remove,
          backgroundColor: dark
              ? UColors.darkerGrey
              : UColors.light,
          size: USizes.iconSm,
          width: 32.0,
          height: 32.0,
          color: dark ? UColors.white : UColors.black,
        ),
        SizedBox(width: USizes.spaceBtwItems),

        // Counter
        Text(
          '2',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(width: USizes.spaceBtwItems),

        UCircularIcon(
          icon: Icons.add,
          backgroundColor: UColors.primary,
          size: USizes.iconSm,
          width: 32.0,
          height: 32.0,
          color: UColors.white,
        ),

      ],
    );
  }
}
