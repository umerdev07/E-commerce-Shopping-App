import 'package:e_commerce/common/widgets/custom_shapes/URoundedContainer.dart';
import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/shop/controllers/checkout/checkout_controller.dart';
import 'package:e_commerce/features/shop/models/payment_method_model.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/uimages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/helpers/helper_function.dart';

class UPaymentBillingSection extends StatelessWidget {
  const UPaymentBillingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckoutController());
    final bool dark = UHelperFunction.isDarkMode(context);
    return Column(
      children: [
        SectionHeading(
          sectionHeading: 'Payment Methods',
          buttonTitle: 'Change',
          onTap: () => controller.selectPaymentMethod(context),
        ),
        SizedBox(height: USizes.spaceBtwItems / 2),

        Row(
          children: [
            URoundedContainer(
              width: 60,
              height: 35,
              backgroundColor: dark ? UColors.light : UColors.white,
              padding: EdgeInsets.all(USizes.sm),
              child: Image(
                image: AssetImage(UImages.masterCard),
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(width: USizes.spaceBtwItems / 2),
            Text('Visa', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ],
    );
  }
}
