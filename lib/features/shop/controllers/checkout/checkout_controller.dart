import 'package:e_commerce/common/widgets/custom_shapes/URoundedContainer.dart';
import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/shop/models/payment_method_model.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/uimages.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  // Variables
  Rx<PaymentMethodModel> selectedPaymentMethod = PaymentMethodModel.isEmpty().obs;


  Future<void> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(USizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeading(
                sectionHeading: 'Select Payment Method',
                showActionButton: false,
              ),
              SizedBox(height: USizes.spaceBtwSections),
              UPaymentTile(paymentMethod: PaymentMethodModel(name: 'Cash on Delivery', image: UImages.cod)),
              SizedBox(height: USizes.spaceBtwItems / 2),
              UPaymentTile(paymentMethod: PaymentMethodModel(name: 'Paypal', image: UImages.paypal)),
              SizedBox(height: USizes.spaceBtwItems / 2),
              UPaymentTile(paymentMethod: PaymentMethodModel(name: 'Master Card', image: UImages.masterCard)),
              SizedBox(height: USizes.spaceBtwItems / 2),
              UPaymentTile(paymentMethod: PaymentMethodModel(name: 'Visa', image: UImages.visa)),
              SizedBox(height: USizes.spaceBtwItems / 2),
              UPaymentTile(paymentMethod: PaymentMethodModel(name: 'Paytm', image: UImages.paytm)),
              SizedBox(height: USizes.spaceBtwItems / 2),

            ],
          ),
        ),
      ),
    );
  }
}

class UPaymentTile extends StatelessWidget {
  const UPaymentTile({super.key, required this.paymentMethod});

  final PaymentMethodModel paymentMethod;

  @override
  Widget build(BuildContext context) {
    final controller = CheckoutController.instance;

    return ListTile(
      onTap: () {
        controller.selectedPaymentMethod.value = paymentMethod;
        Get.back(); // close bottom sheet
      },
      contentPadding: EdgeInsets.zero,
      leading: URoundedContainer(
        width: 60,
        height: 40,
        backgroundColor: UHelperFunction.isDarkMode(context)
            ? UColors.light
            : UColors.white,
        padding: EdgeInsets.all(USizes.sm),
        child: Image(
          image: AssetImage(paymentMethod.image),
          fit: BoxFit.contain,
        ),
      ),
      title: Text(paymentMethod.name),
      trailing: Obx(() {
        return controller.selectedPaymentMethod.value.name ==
            paymentMethod.name
            ? const Icon(Icons.check, color: Colors.green)
            : const Icon(Iconsax.arrow_right_4);
      }),
    );
  }
}