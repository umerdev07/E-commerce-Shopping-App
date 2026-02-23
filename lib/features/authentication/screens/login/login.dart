import 'package:e_commerce/common/styles/u_padding.dart';
import 'package:e_commerce/common/widgets/login_signup/u_loginsignupdivider.dart';
import 'package:e_commerce/features/authentication/controllers/login/login_controller.dart';
import 'package:e_commerce/features/authentication/screens/login/widgets/u_loginfoam.dart';
import 'package:e_commerce/common/widgets/button/u_socialIcons.dart';
import 'package:e_commerce/features/authentication/screens/login/widgets/u_loginheader.dart';
import 'package:e_commerce/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/sizes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());

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
              ULoginHeader(),
        
              SizedBox(height: USizes.spaceBtwSections),
        
              /// Foam
              ULoginFoam(),
        
              SizedBox(height: USizes.spaceBtwSections),
        
              /// [Divider]
              ULoginSignupDivider(title: UTexts.orSignInWith),
        
              SizedBox(height: USizes.spaceBtwSections),
        
              /// [Footer]
              /// Social Buttons
              USocialButton(),
            ],
          ),
        ),
      ),
    );
  }
}



