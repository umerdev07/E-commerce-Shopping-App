import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_function.dart';

class UCartCounterIcon extends StatelessWidget {
  const UCartCounterIcon({
    super.key, required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    bool dark = UHelperFunction.isDarkMode(context);

    return Stack(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(Iconsax.shopping_bag),
          color: UColors.light,
        ),

        Positioned(
          right: 6.8,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: dark ? UColors.dark : UColors.light,
              shape: BoxShape.circle,
            ),
            child: Text(
              '2',
              style: Theme.of(context).textTheme.labelLarge!.apply(
                color: dark ? UColors.white : UColors.dark,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
