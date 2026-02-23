import 'package:e_commerce/features/shop/controllers/product/variation_controller.dart';
import 'package:e_commerce/features/shop/models/product_model.dart';
import 'package:e_commerce/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/chips/choice_chips.dart';
import '../../../../../common/widgets/custom_shapes/URoundedContainer.dart';
import '../../../../../common/widgets/texts/product_price.dart';
import '../../../../../common/widgets/texts/product_title_text.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_function.dart';

class UProductAttributes extends StatelessWidget {
  const UProductAttributes({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final bool dark = UHelperFunction.isDarkMode(context);
    final controller = Get.put(VariationController());

    return Obx(
      () => Column(
        children: [
          // Attribute Pricing & Description
          if(controller.selectedVariation.value.id.isNotEmpty)
          URoundedContainer(
            padding: EdgeInsets.all(USizes.md),
            backgroundColor: dark ? UColors.darkerGrey : UColors.grey,

            // Attributes Details
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Attribute Title
                    SectionHeading(
                      sectionHeading: 'Variation',
                      showActionButton: false,
                    ),
                    SizedBox(width: USizes.spaceBtwItems),

                    // Attribute Pricing and Actual Pricing, Stock
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Attribute Pricing and Actual Pricing
                        Row(
                          children: [
                            UProductTitleText(title: 'Price : ', smallSize: true),

                            if(controller.selectedVariation.value.salesPrice > 0)
                            Text(
                              '${UTexts.currency}${controller.selectedVariation.value.price.toStringAsFixed(0)}',
                              style: Theme.of(context).textTheme.titleSmall!
                                  .apply(decoration: TextDecoration.lineThrough),
                            ),

                            SizedBox(width: USizes.spaceBtwItems),

                            UProductCadPrice(productPrice: controller.getVariationPrice()),
                          ],
                        ),

                        // Attribute Stock
                        Row(
                          children: [
                            UProductTitleText(title: 'Stock : ', smallSize: true),
                            Text(
                              controller.variationStockStatus.value,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                // Attribute Description
                UProductTitleText(
                  title: controller.selectedVariation.value.description ?? '',
                  textAlign: TextAlign.justify,
                  smallSize: true,
                  maxLine: 4,
                ),
              ],
            ),
          ),
          SizedBox(height: USizes.spaceBtwItems),

          /// Attributes - Color
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.productAttributes!.map((attributes) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeading(
                    sectionHeading: attributes.name ?? '',
                    showActionButton: false,
                  ),
                  SizedBox(height: USizes.spaceBtwItems / 2),
                  Obx(() => Wrap(
                      spacing: USizes.sm,
                      children: attributes.values!.map((attributesValues) {
                        final isSelected =
                            controller.selectedAttributes[attributes.name] ==
                            attributesValues;
                        final available = controller.getAttributeAvailabilityInVariation(product.productVariations!, attributes.name!).contains(attributesValues);
                        return UChoiceChip(
                          text: attributesValues,
                          isSelected: isSelected,
                          onSelected: available ? (value) {

                              controller.onAttributeSelected(product, attributes.name!, attributesValues);

                          } : null,
                        );
                      }).toList(),
                    )
                  ),
                ],
              );
            }).toList(),
          ),

          SizedBox(height: USizes.spaceBtwItems),

          /// Attribute - Sizes
        ],
      ),
    );
  }
}
