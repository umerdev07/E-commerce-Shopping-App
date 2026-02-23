import 'package:e_commerce/common/widgets/custom_shapes/URoundedContainer.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class UOrdersListItems extends StatelessWidget {
  const UOrdersListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = UHelperFunction.isDarkMode(context);
    return ListView.separated(

      separatorBuilder: (context, index) =>
          SizedBox(height: USizes.spaceBtwItems),
      itemCount: 10,
      itemBuilder: (context, index) => URoundedContainer(
        width: double.infinity,
        showBorder: true,
        padding: EdgeInsets.all(USizes.md),
        backgroundColor: dark ? UColors.dark : UColors.light,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Row-1
            Row(
              children: [
                Icon(Iconsax.ship),
                SizedBox(width: USizes.spaceBtwItems / 2),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Processing',
                        style: Theme.of(context).textTheme.bodyLarge!.apply(
                          color: UColors.primary,
                          fontWeightDelta: 1,
                        ),
                      ),
                      Text(
                        '02 Feb 2026',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Iconsax.arrow_right_4, size: USizes.iconSm),
                ),
              ],
            ),

            SizedBox(height: USizes.spaceBtwItems),

            /// Row-2
            Row(
              children: [
                Icon(Iconsax.tag),
                SizedBox(width: USizes.spaceBtwItems / 2),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Text(
                        'GYS324',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),

                Icon(Iconsax.calendar),
                SizedBox(width: USizes.spaceBtwItems / 2),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Text(
                        '02 Feb 2026',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}
