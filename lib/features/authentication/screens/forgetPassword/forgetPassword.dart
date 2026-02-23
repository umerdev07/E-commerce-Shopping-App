import 'package:e_commerce/common/styles/u_padding.dart';
import 'package:e_commerce/common/widgets/button/u_elevatedbutton.dart';
import 'package:e_commerce/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:e_commerce/features/authentication/screens/forgetPassword/resetPassword.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/texts.dart';
import 'package:e_commerce/utils/validators/validations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ForgetpasswordScreen extends StatelessWidget {
  const ForgetpasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              SizedBox(height: USizes.defaultSpace),

              /// [Header]
              // Title
              Text(
                UTexts.forgetPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              // Subtitle
              SizedBox(height: USizes.spaceBtwItems / 2),
              Text(
                UTexts.forgetPasswordSubTitle,
                style: Theme.of(context).textTheme.bodySmall,
              ),

              SizedBox(height: USizes.spaceBtwSections * 2),

              /// [Foam]
              Form(
                key: controller.forgotPasswordKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.email,
                      validator: (value) => UValidations.emailValidation(value),
                      decoration: InputDecoration(
                        labelText: UTexts.email,
                        prefixIcon: Icon(Iconsax.direct_right),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: USizes.spaceBtwItems),

              UElevatedButton(
                onPressed: controller.forgetPasswordThroughEmail,
                child: Text(UTexts.submit),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
