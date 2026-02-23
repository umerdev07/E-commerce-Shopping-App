import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/uimages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/constants/colors.dart';

class UAnimationLoader extends StatelessWidget {
  const UAnimationLoader({
    super.key,
    required this.text,
    this.animation = UImages.loadingAnimation,
    this.showActionButton = false,
    this.actionText,
    this.onActionPressed,
  });

  final String text;
  final String animation;
  final bool showActionButton;
  final String? actionText;
  final VoidCallback? onActionPressed;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animation
          Lottie.asset(animation, width: Get.width * 0.8),
          const SizedBox(height: USizes.defaultSpace),

          // Text
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: USizes.defaultSpace),

          showActionButton
              ? SizedBox(
                  width: 250,
                  child: OutlinedButton(
                    onPressed: onActionPressed,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: UColors.dark,
                    ),
                    child: Text(
                      actionText!,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.apply(color: UColors.light),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
