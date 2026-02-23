import 'package:e_commerce/features/shop/controllers/product/favourite_icon_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../icons/circular_icon.dart';

class UFavouriteIcon extends StatelessWidget {
  const UFavouriteIcon({super.key, required this.productId});

  final String productId;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouriteIconController());
    return Obx( () =>
      UCircularIcon(
        icon: controller.isFavourite(productId)
            ? Iconsax.heart
            : Iconsax.heart,
        color: controller.isFavourite(productId) ? Colors.red : Colors.grey,
        onPressed: () => controller.toggleFavoriteIcon(productId),
      ),
    );
  }
}
