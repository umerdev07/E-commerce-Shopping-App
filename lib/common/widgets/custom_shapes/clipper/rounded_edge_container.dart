import 'package:flutter/material.dart';

import 'CustomeRoundedClipper.dart';

class URoundedEdgeContainer extends StatelessWidget {
  const URoundedEdgeContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: UCustomRoundEdges(),
      child: child,
    );
  }
}
