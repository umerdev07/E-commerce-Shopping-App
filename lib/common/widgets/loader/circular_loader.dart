import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class UCircularLoader extends StatelessWidget {
  const UCircularLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(USizes.lg),
      decoration: const BoxDecoration(
        color: UColors.primary,
        shape: BoxShape.circle
      ),
      child: const CircularProgressIndicator(color: UColors.white),
    );
  }
}
