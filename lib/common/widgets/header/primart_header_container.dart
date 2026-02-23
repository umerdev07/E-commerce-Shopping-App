import 'package:flutter/material.dart';

import '../../../../../common/widgets/custom_shapes/UCircularContainer.dart';
import '../../../../../common/widgets/custom_shapes/clipper/rounded_edge_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../utils/helpers/device_helper.dart';

class UPrimaryHeaderContainer extends StatelessWidget {
  const UPrimaryHeaderContainer({
    super.key,
    required this.child, required this.height,
  });

  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = UDeviceHelper.getScreenHeight(context);
    final double screenWidth = UDeviceHelper.getScreenWidth(context);
    return URoundedEdgeContainer(
      child: Container(
        height: height,
        width: double.infinity,
        color: UColors.primary,
        child: Stack(
          children: [
            // Circle 1
            Positioned(
              top: -screenWidth * 0.25,
              right: -screenWidth * 0.45,
              child: UCircularContainer(
                height: screenHeight * 0.33,
                width: screenHeight * 0.4,
                backgroundColor: UColors.white.withValues(alpha: 0.1),

              ),
            ),

            // Circle 2
            Positioned(
              top: screenHeight * 0.08,
              right: -screenWidth * 0.67,
              child: UCircularContainer(
                height: screenHeight * 0.3,
                width: screenHeight * 0.4,
                backgroundColor: UColors.white.withValues(alpha: 0.1),
              ),
            ),

            ///
            child
          ],
        ),
      ),
    );
  }
}

