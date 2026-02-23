import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';

import '../../../utils/constants/colors.dart';

class URoundedContainer extends StatelessWidget {
  const URoundedContainer({
    super.key,
    this.width,
    this.height,
    this.radius = USizes.cardRadiusLg,
    this.showBorder = false,
    this.child,
    this.borderColor = UColors.borderPrimary,
    this.backgroundColor = UColors.white,
    this.padding,
    this.margin,
  });

  final double? width, height;
  final double radius;
  final bool showBorder;
  final Widget? child;
  final Color borderColor, backgroundColor;
  final EdgeInsetsGeometry? padding, margin;

  @override
  Widget build(BuildContext context) {
      return Container(
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius),
          border: showBorder ? BoxBorder.all(color: borderColor) : null
        ),

        child: child,
      );
  }
}
