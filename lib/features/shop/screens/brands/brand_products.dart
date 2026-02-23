import 'package:e_commerce/common/styles/u_padding.dart';
import 'package:e_commerce/common/widgets/brands/brand_card.dart';
import 'package:e_commerce/common/widgets/shimmer/verical_product_shimmer.dart';
import 'package:e_commerce/features/shop/controllers/brand/brand_controller.dart';
import 'package:e_commerce/features/shop/models/brand_model.dart';
import 'package:e_commerce/features/shop/models/product_model.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_function.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/products/product_with_filter/all_product_filter.dart';

class BrandProductsScreen extends StatelessWidget {
  const BrandProductsScreen({super.key, required this.title, required this.brand});

  final String title;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(title, style: Theme.of(context).textTheme.headlineMedium),
    ),
          body: SingleChildScrollView(
            child: Padding(padding: UPadding.screenPadding,
            child: Column(
                children: [

                  UBrandCard(brandModel: brand),
                  SizedBox(height: USizes.spaceBtwSections),

                  FutureBuilder(
                      future: controller.getSpecificBrandProducts(brand.id),
                    builder: (context, snapshot) {

                      // HANDLE LOADING ERRORS AND NULL
                      const loader = UVerticalProductShimmer();
                      Widget? widget = UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                      if(widget != null) return widget;

                      // Data
                      List<ProductModel> products = snapshot.data!;
                      return UAllProductsWithFilter(product: products);
                    })
              ],
            ),),
          )
    );
  }
}
