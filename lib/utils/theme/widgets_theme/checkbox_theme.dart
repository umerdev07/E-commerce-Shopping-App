
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class UCheckBoxTheme{
  UCheckBoxTheme._();

  static CheckboxThemeData lightCheckBoxTheme = CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(USizes.xs)),
      checkColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.selected)){
          return UColors.white;
        }else{
          return UColors.black;
        }
      }),
    fillColor: WidgetStateColor.resolveWith((states) {
      if(states.contains(WidgetState.selected)) {
        return UColors.primary;
      }else{
        return Colors.transparent;
      }
    })
  );

  static CheckboxThemeData darkCheckBoxTheme = CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(USizes.xs)),
      checkColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.selected)){
          return UColors.white;
        }else{
          return UColors.black;
        }
      }),
      fillColor: WidgetStateColor.resolveWith((states) {
        if(states.contains(WidgetState.selected)) {
          return UColors.primary;
        }else{
          return Colors.transparent;
        }
      })
  );
}