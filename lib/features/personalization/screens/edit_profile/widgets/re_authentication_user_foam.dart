import 'package:e_commerce/common/styles/u_padding.dart';
import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/common/widgets/button/u_elevatedbutton.dart';
import 'package:e_commerce/features/personalization/controllers/user_controller.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/validators/validations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ReAuthenticationUserFoamScreen extends StatelessWidget {
  const ReAuthenticationUserFoamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          'Re-Authentication User',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Form(
            key: controller.re_AuthenticationKey,
            child: Column(
              children: [
                SizedBox(height: USizes.spaceBtwSections),
                // Email
                TextFormField(
                  controller: controller.email,
                  validator: UValidations.emailValidation,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Iconsax.direct_right),
                  ),
                ),
                SizedBox(height: USizes.spaceBtwItems),
                // Password
                Obx(
                  () => TextFormField(
                    controller: controller.password,
                    validator: (value) =>
                        UValidations.validationEmptyText('Password', value),
                    obscureText: controller.isPasswordVisible.value,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Iconsax.password_check),
                      suffixIcon: IconButton(
                        onPressed: () => controller.isPasswordVisible.toggle(),
                        icon: Icon(
                          controller.isPasswordVisible.value
                              ? Iconsax.eye_slash
                              : Iconsax.eye,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: USizes.spaceBtwSections),

                // Login Button
                UElevatedButton(onPressed: controller.reAuthenticateUser, child: Text('Verify')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
