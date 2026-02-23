
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class UChipTheme{

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: UColors.grey.withValues(alpha: 0.4),
    labelStyle: const TextStyle(color: Colors.black),
    selectedColor: UColors.primary,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: UColors.white
  );

  static ChipThemeData darkChipTheme = ChipThemeData(
      disabledColor: UColors.darkerGrey,
      labelStyle: const TextStyle(color: Colors.white),
      selectedColor: UColors.primary,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
      checkmarkColor: UColors.white
  );

}