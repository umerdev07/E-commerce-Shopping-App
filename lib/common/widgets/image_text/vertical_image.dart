import 'package:e_commerce/common/widgets/images/circular_image.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_function.dart';
import '../custom_shapes/UCircularContainer.dart';

class UVericalImageText extends StatelessWidget {
  const UVericalImageText({
    super.key, required this.categoryTitle, required this.categoryImage, required this.textColor, this.backgroundColor, this.onTap,
  });

  final String categoryTitle, categoryImage;
  final Color textColor;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    bool dark = UHelperFunction.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          UCircularImage(
              height: 60,
              width: 60,
              image: categoryImage,
              isNetworkImage: true,
          ),

          Padding(
            padding:  EdgeInsets.only(top: USizes.sm),
            child: SizedBox(
              width: 59,
              child: Text(
                categoryTitle,
                style: Theme.of(
                  context,
                ).textTheme.labelMedium!.apply(color: textColor),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}