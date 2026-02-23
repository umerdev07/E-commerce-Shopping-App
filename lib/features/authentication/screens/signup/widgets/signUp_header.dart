import 'package:flutter/material.dart';

import '../../../../../utils/constants/texts.dart';

class signUpHeader extends StatelessWidget {
  const signUpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          UTexts.signupScreenTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    );
  }
}
