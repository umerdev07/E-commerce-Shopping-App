import 'package:e_commerce/common/widgets/texts/product_brand.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/enum.dart';
import '../../../utils/constants/sizes.dart';

class UBrandTitleWitVerifyIcon extends StatelessWidget {
  const UBrandTitleWitVerifyIcon({
    super.key,
    this.textColor,
    this.iconColor = UColors.primary,
    required this.title,
    this.maxLine = 1,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSizes.small,
  });

  final Color? textColor, iconColor;
  final String title;
  final int maxLine;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: UBrandTitleText(
            title: title,
            maxLine: maxLine,
            textAlign: textAlign,
            brandTextSize: brandTextSize,
          ),
        ),

        SizedBox(width: USizes.xs),

        Icon(Iconsax.verify, color: UColors.primary, size: USizes.iconXs),
      ],
    );
  }
}
