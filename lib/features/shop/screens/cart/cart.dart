import 'package:e_commerce/common/styles/u_padding.dart';
import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/common/widgets/button/u_elevatedbutton.dart';
import 'package:e_commerce/common/widgets/loader/animation_loader.dart';
import 'package:e_commerce/features/shop/controllers/cart/cart_controller.dart';
import 'package:e_commerce/features/shop/screens/cart/widgets/u_cart_items.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/texts.dart';
import 'package:e_commerce/utils/constants/uimages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/keys/keys.dart';
import '../checkout/checkout.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text('Cart', style: Theme.of(context).textTheme.headlineMedium),
      ),

      body: Obx(() {

        final emptyWidget = UAnimationLoader(text: 'Cart is Empty', animation: UImages.loadingCartEmpty,
        showActionButton: true,
          actionText: "Let's fill it",
          onActionPressed: Get.back,
        );

        if (controller.cartItem.isEmpty) {
          return Center(child: emptyWidget);
        }

        return SingleChildScrollView(
          child: Padding(
            padding: UPadding.screenPadding,
            child: UCartItems(neverScrollable: false),
          ),
        );
      }),
      bottomNavigationBar: Obx(() {
        if (controller.cartItem.isEmpty) return SizedBox();
        return Padding(
          padding: const EdgeInsets.all(USizes.defaultSpace),
          child: UElevatedButton(
            child: Text(
              'Checkout ${UTexts.currency}${controller.totalCartPrice.value.toStringAsFixed(2)}',
            ),
            onPressed: () => Get.to(() => CheckoutScreen()),
          ),
        );
      }),
    );
  }
}
