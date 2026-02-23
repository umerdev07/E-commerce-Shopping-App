import 'package:e_commerce/common/styles/u_padding.dart';
import 'package:e_commerce/common/widgets/button/u_elevatedbutton.dart';
import 'package:e_commerce/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:e_commerce/features/authentication/screens/login/login.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/texts.dart';
import 'package:e_commerce/utils/constants/uimages.dart';
import 'package:e_commerce/utils/helpers/device_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, this.text});

  final String? text;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.offAll(() => LoginScreen()),
            icon: Icon(CupertinoIcons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: USizes.defaultSpace),

              /// Image
              Image.asset(
                UImages.mailSentImage,
                height: UDeviceHelper.getScreenWidth(context) * 0.7,
              ),

              /// Title
              Text(
                UTexts.resetPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: USizes.spaceBtwItems),

              /// Email
              Text(text!, style: Theme.of(context).textTheme.labelLarge),
              SizedBox(height: USizes.spaceBtwItems),

              /// Sub Title
              Text(
                UTexts.resetPasswordSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: USizes.spaceBtwItems),

              /// Button
              UElevatedButton(
                onPressed: () => Get.offAll(() => LoginScreen()),
                child: Text(UTexts.done),
              ),
              SizedBox(height: USizes.spaceBtwItems / 2),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => controller.resendPasswordThroughEmail(text!),
                  child: Text(UTexts.resentEmail),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
