import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class UProductCadPrice extends StatelessWidget {
  const UProductCadPrice({
    super.key,
    required this.productPrice,
    this.maxlines = 1,
    this.currentSign = '\$',
    this.isLarge = false,
    this.lineThrough = false,
  });

  final String productPrice;
  final int? maxlines;
  final String currentSign;
  final bool isLarge, lineThrough;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: USizes.sm),
      child: Text(
        currentSign + ' ' + productPrice,
        style: isLarge
            ? Theme.of(context).textTheme.headlineMedium!.apply(
                decoration: lineThrough ? TextDecoration.lineThrough : null,
              )
            : Theme.of(context).textTheme.titleLarge!.apply(
                decoration: lineThrough ? TextDecoration.lineThrough : null,
              ),
        maxLines: maxlines,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
