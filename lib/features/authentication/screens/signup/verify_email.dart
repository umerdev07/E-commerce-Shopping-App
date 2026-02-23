import 'package:e_commerce/common/styles/u_padding.dart';
import 'package:e_commerce/common/widgets/button/u_elevatedbutton.dart';
import 'package:e_commerce/data/repository/authentication_repository.dart';
import 'package:e_commerce/features/authentication/controllers/signUp/verify_email_controller.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/texts.dart';
import 'package:e_commerce/utils/constants/uimages.dart';
import 'package:e_commerce/utils/helpers/device_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () async => await AuthenticationRepository.instance.logOut(),
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
                UTexts.verifyEmailTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: USizes.spaceBtwItems),

              /// Email
              Text(email ?? '', style: Theme.of(context).textTheme.labelLarge),
              SizedBox(height: USizes.spaceBtwItems),

              /// Sub Title
              Text(
                UTexts.verifyEmailSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: USizes.spaceBtwItems),

              /// Button
              UElevatedButton(
                onPressed: () => controller.checkEmailVerificationStatus,
                child: Text(UTexts.continues),
              ),

              SizedBox(height: USizes.spaceBtwItems / 2),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: controller.onSendEmailVerification,
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
