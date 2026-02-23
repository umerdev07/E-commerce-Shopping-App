import 'package:e_commerce/common/styles/u_padding.dart';
import 'package:e_commerce/common/widgets/button/u_socialIcons.dart';
import 'package:e_commerce/common/widgets/login_signup/u_loginsignupdivider.dart';
import 'package:e_commerce/features/authentication/screens/signup/widgets/signUp_header.dart';
import 'package:e_commerce/features/authentication/screens/signup/widgets/signup_foam.dart';
import 'package:e_commerce/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/sizes.dart';
import '../../controllers/signUp/signup_controller.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignupController());
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
              signUpHeader(),
              SizedBox(height: USizes.spaceBtwSections),

              /// [SignUp Foam]
              signUpFoam(),

              SizedBox(height: USizes.spaceBtwSections),

              /// [Divider]
              ULoginSignupDivider(title: UTexts.orSignUpWith),

              SizedBox(height: USizes.spaceBtwSections),

              // Footer
              /// [Social Button]
              USocialButton(),
            ],
          ),
        ),
      ),
    );
  }
}
