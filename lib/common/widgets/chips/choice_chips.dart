import 'package:e_commerce/common/widgets/custom_shapes/UCircularContainer.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class UChoiceChip extends StatelessWidget {
  const UChoiceChip({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onSelected,
  });

  final String text;
  final bool isSelected;
  final ValueChanged<bool>? onSelected;

  @override
  Widget build(BuildContext context) {
    final Color? color = UHelperFunction.getColor(text);
    final bool isColor = color != null;

    return ChoiceChip(
      label: isColor ? const SizedBox() : Text(text),
      selected: isSelected,
      onSelected: onSelected,
      labelStyle: TextStyle(
        color: isSelected ? UColors.white : null,
      ),
      avatar: isColor
          ? UCircularContainer(
        width: 50.0,
        height: 50.0,
        backgroundColor: color,
      )
          : null,
      shape: isColor ? const CircleBorder() : null,
      padding: isColor ? EdgeInsets.zero : null,
      labelPadding: isColor ? EdgeInsets.zero : null,
      backgroundColor: isColor ? color : null,
    );
  }
}
