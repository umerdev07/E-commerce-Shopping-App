import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';

class UShadow {
  UShadow._();

  static List<BoxShadow> searchBarshadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.1),
      spreadRadius: 4.0,
      blurRadius: 4.0,
    ),
  ];

  static List<BoxShadow> vericalProductShadow = [
    BoxShadow(
      color: UColors.darkGrey.withValues(alpha: 0.1),
      spreadRadius: 7,
      blurRadius: 50,
      offset: const Offset(0, 2),
    ),
  ];
}
