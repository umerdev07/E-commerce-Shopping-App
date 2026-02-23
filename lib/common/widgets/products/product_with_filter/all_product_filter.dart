import 'package:e_commerce/features/shop/controllers/product/all_products_controller.dart';
import 'package:e_commerce/features/shop/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../utils/constants/sizes.dart';
import '../../layouts/grid_layout.dart';
import '../card/product_card_vertical.dart';

class UAllProductsWithFilter extends StatelessWidget {
  const UAllProductsWithFilter({
    super.key, required this.product,
  });

  final List<ProductModel> product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    controller.assignProduct(product);
    return Column(
      children: [
        SizedBox(height: USizes.spaceBtwItems),
        DropdownButtonFormField(
          value: controller.selectedSortOption.value,
          decoration: InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          onChanged: (value) => controller.sortProduct(value!),
          items: ['Name', 'Lower Price', 'Higher Price', 'Sale', 'Newest']
              .map((filter) {
            return DropdownMenuItem(
              value: filter,
              child: Text(filter),
            );
          })
              .toList(),
        ),

        SizedBox(height: USizes.spaceBtwItems),

        Obx( () =>
          UGridLayout(
            itemCount: controller.product.length,
            itemBuilder: (BuildContext context, int index) {
              return UProductCardVertical(product: controller.product[index]);
            },
          ),
        ),
      ],
    );
  }
}
