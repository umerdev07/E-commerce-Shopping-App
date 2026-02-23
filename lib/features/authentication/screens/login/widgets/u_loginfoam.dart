import 'package:e_commerce/features/authentication/controllers/login/login_controller.dart';
import 'package:e_commerce/features/authentication/screens/forgetPassword/forgetPassword.dart';
import 'package:e_commerce/features/authentication/screens/signup/signup.dart';
import 'package:e_commerce/utils/validators/validations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../../common/widgets/button/u_elevatedbutton.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';

class ULoginFoam extends StatelessWidget {
  const ULoginFoam({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = LoginController.instance;
    return Form(
      key: controller.loginKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Email
          TextFormField(
            controller: controller.email,
            validator: (value) => UValidations.emailValidation(value),
            decoration: InputDecoration(
              labelText: UTexts.email,
              prefixIcon: Icon(Iconsax.direct_right),
            ),
          ),
          SizedBox(height: USizes.spaceBtwInputFields),
          // Password
          Obx( () => TextFormField(
              controller: controller.password,
              validator: (value) => UValidations.validationEmptyText('Password', value),
              obscureText: controller.isPasswordVisible.value,
              decoration: InputDecoration(
                labelText: UTexts.password,
                prefixIcon: Icon(Iconsax.password_check_copy),
                suffixIcon: IconButton(
                    onPressed: () => controller.isPasswordVisible.toggle(),
                    icon: Icon(controller.isPasswordVisible.value? Iconsax.eye_slash : Iconsax.eye)
                ),
              ),
            ),
          ),
          SizedBox(height: USizes.spaceBtwInputFields / 2),

          // Remember Me && Forgot Password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Row(
                  children: [
                    Checkbox(
                      value: controller.rememberMe.value,
                      onChanged: (value) => controller.rememberMe.value =
                          !controller.rememberMe.value,
                    ),
                    Text(UTexts.rememberMe),
                  ],
                ),
              ),
              // Forgot Password
              TextButton(
                onPressed: () => Get.to(() => ForgetpasswordScreen()),
                child: Text(UTexts.forgotPassword),
              ),
            ],
          ),
          SizedBox(height: USizes.spaceBtwSections),
          // Sign In
          UElevatedButton(
            onPressed: controller.login,
            child: Text(UTexts.signIn),
          ),
          SizedBox(height: USizes.spaceBtwItems / 2),
          // Create Account
          SizedBox(
            width: double.infinity,

            child: OutlinedButton(
              child: Text(UTexts.createAccount),
              onPressed: () => Get.to(() => SignupScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
