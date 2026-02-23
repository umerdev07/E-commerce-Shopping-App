import 'package:e_commerce/features/shop/screens/cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/header/primart_header_container.dart';
import '../../../../../common/widgets/products/cart/cart_counter_icon.dart';
import '../../../../../common/widgets/textFields/search_bar.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class UStorePrimaryHeader extends StatelessWidget {
  const UStorePrimaryHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: USizes.storePrimaryHeaderHeight + 10,
        ),

        /// --------- [UPPER PART] -----------
        UPrimaryHeaderContainer(
          height: USizes.storePrimaryHeaderHeight,
          child: UAppBar(
            title: Text('Store', style: Theme.of(context).textTheme.headlineMedium!.apply(color: UColors.white)),
            actions: [
              UCartCounterIcon(onPressed: () => Get.to(() => CartScreen()))
            ],
          ),
        ),
        // Search Bar
        searchBar(),
      ],
    );
  }
}