import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/common/widgets/icons/circular_icon.dart';
import 'package:e_commerce/common/widgets/loader/animation_loader.dart';
import 'package:e_commerce/common/widgets/products/card/product_card_vertical.dart';
import 'package:e_commerce/common/widgets/shimmer/verical_product_shimmer.dart';
import 'package:e_commerce/features/shop/controllers/product/favourite_icon_controller.dart';
import 'package:e_commerce/navigationMenu.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../utils/constants/uimages.dart';
import '../../models/product_model.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavouriteIconController.instance;
    return Scaffold(
      appBar: UAppBar(
        title: Text(
          'Wish List',
          style: Theme.of(context).textTheme.headlineMedium,
        ),

        actions: [
          UCircularIcon(
            icon: Iconsax.add,
            onPressed: () =>
                NavigationController.instance.selectedIndex.value = 0,
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(USizes.defaultSpace),
          child: Obx(
            () => FutureBuilder(
              future: controller.getFavouriteProducts(),
              builder: (context, snapshot) {

                final loader = UVerticalProductShimmer();

                final nothingFound = UAnimationLoader(
                  text: 'Wishlist is Empty...',
                  showActionButton: true,
                  actionText: "Let's add some",
                  animation: UImages.loadingPencilDrawing,
                  onActionPressed: () =>
                      NavigationController.instance.selectedIndex.value = 0,
                );

                final widget = UCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot,
                  loader: loader,
                  nothingFound: nothingFound,
                );

                if (widget != null) return widget;

                List<ProductModel> products = snapshot.data!;
                return UGridLayout(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    ProductModel productModel = products[index];
                    return UProductCardVertical(product: productModel);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
