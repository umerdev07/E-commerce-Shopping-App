import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class UShippingAddressSection extends StatelessWidget {
  const UShippingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          SectionHeading(sectionHeading: 'Shipping Address', buttonTitle: 'Change', onTap: (){}),

        SizedBox(height: USizes.spaceBtwItems / 2),
        Text('Umer Dev', style: Theme.of(context).textTheme.bodyLarge),
        SizedBox(height: USizes.spaceBtwItems / 2),

        Row(
          children: [
            Icon(Icons.phone, size: USizes.iconMd, color: UColors.darkerGrey),
            SizedBox(width: USizes.spaceBtwItems / 2),
            Text('+923001234567', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        SizedBox(height: USizes.spaceBtwItems / 2),
        Row(
          children: [
            Icon(Icons.person, size: USizes.iconMd, color: UColors.darkerGrey),
            SizedBox(width: USizes.spaceBtwItems / 2),
            Expanded(child: Text('House No. 464, F Block Jubilee Town Lahore', softWrap: true, style: Theme.of(context).textTheme.bodyMedium)),
          ],
        )
      ]
    );
  }
}
