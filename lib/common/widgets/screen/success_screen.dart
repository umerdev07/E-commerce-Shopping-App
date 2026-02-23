import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:get/get.dart';

import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/texts.dart';
import '../../../utils/helpers/device_helper.dart';
import '../../styles/u_padding.dart';
import '../button/u_elevatedbutton.dart';


class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.onTap,
  });

  final String title, subtitle, image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min, // important for center
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Image
              Image.asset(
                image,
                height: UDeviceHelper.getScreenWidth(context) * 0.6,
              ),

              SizedBox(height: USizes.spaceBtwSections),

              /// Title
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: USizes.spaceBtwItems),

              /// Subtitle
              Text(
                subtitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: USizes.spaceBtwSections),

              /// Button
              UElevatedButton(
                onPressed: onTap,
                child: Text(UTexts.continues),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
