import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UShimmerEffect extends StatelessWidget{
  const UShimmerEffect({ super.key,
    required this.width, required this.height, this.radius = 15, this.color});

  final double width, height, radius;
  final Color? color;
  @override
  Widget build(BuildContext context) {
      final bool dark = UHelperFunction.isDarkMode(context);
      return Shimmer.fromColors(
          baseColor: dark ? Colors.grey[850]! : Colors.grey[300]!,
        highlightColor: dark ? Colors.grey[700]! : Colors.grey[100]!,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color ?? (dark ? UColors.darkerGrey : UColors.dark),
            borderRadius: BorderRadius.circular(radius)
          ),
        ),
      );
  }

}