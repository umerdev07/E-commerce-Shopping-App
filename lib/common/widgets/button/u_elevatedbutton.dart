import 'package:flutter/material.dart';

import '../../../utils/helpers/device_helper.dart';

class UElevatedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  const UElevatedButton({
    super.key,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: UDeviceHelper.getScreenWidth(context),
      child: ElevatedButton(onPressed: onPressed, child: child),
    );
  }
}
