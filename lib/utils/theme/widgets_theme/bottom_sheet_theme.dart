import 'package:flutter/material.dart';

class UBottomSheetTheme{

  UBottomSheetTheme._();

  static BottomSheetThemeData lightBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: Colors.white,
    modalBackgroundColor: Colors.white,
    constraints: const BoxConstraints(maxHeight: 0.9),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0))
  );

  static BottomSheetThemeData darkBottomSheetTheme = BottomSheetThemeData(
      showDragHandle: true,
      backgroundColor: Colors.black,
      modalBackgroundColor: Colors.black,
      constraints: const BoxConstraints(maxHeight: 0.9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0))
  );


}