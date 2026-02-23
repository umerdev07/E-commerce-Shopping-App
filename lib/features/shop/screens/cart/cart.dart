import 'package:e_commerce/common/styles/u_padding.dart';
import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/common/widgets/button/u_elevatedbutton.dart';
import 'package:e_commerce/features/shop/screens/cart/widgets/u_cart_items.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../checkout/checkout.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text('Cart', style: Theme.of(context).textTheme.headlineMedium),
      ),

      body: Padding(
        padding: UPadding.screenPadding,
        child: UCartItems(neverScrollable: false),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(USizes.defaultSpace),
        child: UElevatedButton(child: Text('Checkout \$2445'), onPressed: () => Get.to(() => CheckoutScreen())),
      ),
    );
  }
}


