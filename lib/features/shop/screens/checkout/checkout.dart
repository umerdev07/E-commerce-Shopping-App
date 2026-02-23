import 'package:e_commerce/common/styles/u_padding.dart';
import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/common/widgets/button/u_elevatedbutton.dart';
import 'package:e_commerce/common/widgets/custom_shapes/URoundedContainer.dart';
import 'package:e_commerce/common/widgets/screen/success_screen.dart';
import 'package:e_commerce/features/shop/screens/cart/widgets/u_cart_items.dart';
import 'package:e_commerce/common/widgets/textFields/promo_code.dart';
import 'package:e_commerce/features/shop/screens/checkout/widgets/amount_billing_section.dart';
import 'package:e_commerce/features/shop/screens/checkout/widgets/payment_billing_section.dart';
import 'package:e_commerce/features/shop/screens/checkout/widgets/shipping_address_billing_section.dart';
import 'package:e_commerce/navigationMenu.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/uimages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //---------- [App Bar] -----------
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          'Order Review',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),

      //---------- [Body] -----------
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              SizedBox(height: USizes.spaceBtwSections),
              // Items
              UCartItems(showAddRemoveButtons: false),
              SizedBox(height: USizes.spaceBtwSections),

              // Promo Code - TextField
              UPromoCodeField(),

              SizedBox(height: USizes.spaceBtwSections),

              // Billing Section
              URoundedContainer(
                showBorder: true,
                padding: EdgeInsets.all(USizes.md),
                backgroundColor: Colors.transparent,
                child: Column(
                  children: [
                    /// Amount
                    UAmountBillingSection(),

                    SizedBox(height: USizes.spaceBtwItems),

                    /// Payment
                    UPaymentBillingSection(),

                    SizedBox(height: USizes.spaceBtwItems),

                    /// Shipping Address
                    UShippingAddressSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(USizes.defaultSpace),
        child: UElevatedButton(

          onPressed: () => Get.to(
                () => SuccessScreen(
              title: 'Payment Success',
              subtitle: 'Your item will be shipping soon',
              image: UImages.successfullPayment,
              onTap: () => Get.offAll(() => NavigationMenu()),
            ),
          ),
          child: Text('Checkout \$2445'),

        ),
      ),
    );
  }
}
