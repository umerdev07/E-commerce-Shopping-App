import 'package:e_commerce/utils/theme/widgets_theme/appbar_theme.dart';
import 'package:e_commerce/utils/theme/widgets_theme/bottom_sheet_theme.dart';
import 'package:e_commerce/utils/theme/widgets_theme/checkbox_theme.dart';
import 'package:e_commerce/utils/theme/widgets_theme/chip_theme.dart';
import 'package:e_commerce/utils/theme/widgets_theme/elevated_button_theme.dart';
import 'package:e_commerce/utils/theme/widgets_theme/input_decoration_theme.dart';
import 'package:e_commerce/utils/theme/widgets_theme/outlined_button_theme.dart';
import 'package:e_commerce/utils/theme/widgets_theme/text_theme.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class UAppTheme
{

    // private constructor
    UAppTheme._();

    static ThemeData lightTheme = ThemeData(
        useMaterial3: true,
        fontFamily: 'Nunito',
        brightness: Brightness.light,
        primaryColor: UColors.primary,
        disabledColor: UColors.grey,
        textTheme: UTextTheme.lightTextTheme,
        chipTheme: UChipTheme.lightChipTheme,
        scaffoldBackgroundColor: UColors.white,
        appBarTheme: UAppBarTheme.lightAppBarTheme,
        checkboxTheme: UCheckBoxTheme.lightCheckBoxTheme,
        bottomSheetTheme: UBottomSheetTheme.lightBottomSheetTheme,
        elevatedButtonTheme: UElevatedButtonTheme.lightElevatedButtonTheme,
        outlinedButtonTheme: UOutlinedButtonTheme.lightOutlinedButtonTheme,
        inputDecorationTheme: UInputDecorationTheme.lightInputDecorationTheme
    );

    static ThemeData darkTheme = ThemeData(
        useMaterial3: true,
        fontFamily: 'Nunito',
        brightness: Brightness.dark,
        primaryColor: UColors.primary,
        disabledColor: UColors.grey,
        textTheme: UTextTheme.darkTextTheme,
        chipTheme: UChipTheme.darkChipTheme,
        scaffoldBackgroundColor: UColors.black,
        appBarTheme: UAppBarTheme.darkAppBarTheme,
        checkboxTheme: UCheckBoxTheme.darkCheckBoxTheme,
        bottomSheetTheme: UBottomSheetTheme.darkBottomSheetTheme,
        elevatedButtonTheme: UElevatedButtonTheme.darkElevatedButtonTheme,
        outlinedButtonTheme: UOutlinedButtonTheme.darkOutlinedButtonTheme,
        inputDecorationTheme: UInputDecorationTheme.darkInputDecorationTheme
    );
}
