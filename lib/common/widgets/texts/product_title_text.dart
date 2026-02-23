import 'package:flutter/material.dart';

class UProductTitleText extends StatelessWidget {
  const UProductTitleText({
    super.key,
    required this.title,
    this.smallSize = false,
    this.maxLine = 2,
    this.textAlign = TextAlign.center,
  });

  final String title;
  final bool smallSize;
  final int maxLine;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: smallSize
              ? Theme.of(context).textTheme.labelLarge
              : Theme.of(context).textTheme.titleSmall,
          maxLines: maxLine,
          textAlign: textAlign,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
