import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/texts.dart';
import '../../../utils/helpers/helper_function.dart';
import '../../styles/u_shadow.dart';

// ignore: camel_case_types
class searchBar extends StatelessWidget {
  const searchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool dark = UHelperFunction.isDarkMode(context);

    return Positioned(
      bottom: 0,
      right: USizes.spaceBtwSections,
      left: USizes.spaceBtwSections,
      child: Container(
          height: USizes.searchBarHeight,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(USizes.borderRadiusLg),
              color: dark ? UColors.dark : UColors.white,
              boxShadow: UShadow.searchBarshadow
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: USizes.md),
            child: Row(
              children: [
                Icon(Iconsax.search_normal_1, color: dark ? UColors.white : UColors.darkGrey),
                SizedBox(width: USizes.spaceBtwItems),
                Text(UTexts.homeSearchBarTitle , style:  Theme.of(context).textTheme.bodySmall)
              ],
            ),
          )
      ),

    );
  }
}
