import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';

class ULoginHeader extends StatelessWidget {
  const ULoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title
        Text(
          UTexts.loginScreenTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(height: USizes.sm),

        /// Sub Title
        Text(
          UTexts.loginScreenSubTitle,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
