import 'package:flutter/material.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.sectionHeading,
    this.buttonTitle = 'View all',
    this.onTap,
    this.showActionButton = true,
  });

  final String sectionHeading, buttonTitle;
  final VoidCallback? onTap;
  final bool showActionButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(sectionHeading, style: Theme.of(context).textTheme.headlineSmall),
        if(showActionButton) TextButton(onPressed: onTap, child: Text(buttonTitle, style: Theme.of(context).textTheme.labelLarge))
      ],
    );
  }
}
