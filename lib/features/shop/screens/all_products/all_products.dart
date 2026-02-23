import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/common/styles/u_padding.dart';
import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/common/widgets/shimmer/verical_product_shimmer.dart';
import 'package:e_commerce/features/shop/controllers/product/all_products_controller.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/products/product_with_filter/all_product_filter.dart';
import '../../models/product_model.dart';

class AllProductsScreen extends StatelessWidget {
   AllProductsScreen({super.key, this.query, this.futureMethod, required this.title});

  final String title;
  final Future<List<ProductModel>>? futureMethod;
  Query? query;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: FutureBuilder(future: futureMethod ?? controller.fetchProductFromQuery(query), builder: (context, snapshot) {
            const loader = UVerticalProductShimmer();
            final widget = UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
            if(widget != null) return widget;

            List<ProductModel> products = snapshot.data!;
            return UAllProductsWithFilter(product: products);
          })
        ),
      ),
    );
  }
}

