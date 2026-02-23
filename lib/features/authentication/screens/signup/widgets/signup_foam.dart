import 'package:e_commerce/features/authentication/controllers/signUp/signup_controller.dart';
import 'package:e_commerce/features/authentication/screens/signup/widgets/privacy_policy.dart';
import 'package:e_commerce/utils/validators/validations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../../common/widgets/button/u_elevatedbutton.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';

class signUpFoam extends StatelessWidget {
  const signUpFoam({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    return Form(
      key: controller.signUpKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) =>
                      UValidations.validationEmptyText('First Name', value),
                  decoration: InputDecoration(
                    labelText: UTexts.signupFirstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              SizedBox(width: USizes.spaceBtwInputFields), // horizontal spacing
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      UValidations.validationEmptyText('Last Name', value),
                  decoration: InputDecoration(
                    labelText: UTexts.signupLastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: USizes.spaceBtwInputFields),

          TextFormField(
            controller: controller.email,
            validator: (value) => UValidations.emailValidation(value),
            decoration: InputDecoration(
              labelText: UTexts.email,
              prefixIcon: Icon(Iconsax.direct_right),
            ),
          ),
          SizedBox(height: USizes.spaceBtwInputFields),

          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => UValidations.phoneNumberValidation(value),

            decoration: InputDecoration(
              labelText: UTexts.signupPhoneNumber,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),

          SizedBox(height: USizes.spaceBtwInputFields),

          Obx(
            () => TextFormField(
              controller: controller.password,
              validator: (value) => UValidations.passwordValidation(value),
              obscureText: controller.isPasswordVisible.value,
              decoration: InputDecoration(
                labelText: UTexts.password,
                prefixIcon: Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () => controller.isPasswordVisible.value =
                      !controller.isPasswordVisible.value,
                  icon: Icon(
                    controller.isPasswordVisible.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: USizes.spaceBtwInputFields / 2),

          // CheckBox of Privacy Policy
          privacyPolicy(),

          SizedBox(height: USizes.spaceBtwSections / 2),

          UElevatedButton(
            child: Text(UTexts.createAccount),
            onPressed: controller.registered,
          ),
        ],
      ),
    );
  }
}
