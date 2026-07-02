import 'package:e_commerce/common/styles/u_padding.dart';
import 'package:e_commerce/common/widgets/button/u_elevatedbutton.dart';
import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/shop/screens/product_details/widgets/bottom_add_to_cart.dart';
import 'package:e_commerce/features/shop/screens/product_details/widgets/product_attribute.dart';
import 'package:e_commerce/features/shop/screens/product_details/widgets/product_image_with_slider.dart';
import 'package:e_commerce/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:e_commerce/utils/constants/enum.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../models/product_model.dart';


class UProductDetailScreen extends StatelessWidget {
  const UProductDetailScreen({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// --------- [Body] ---------
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// ------------ [Product Image and Slider] -------------
            ProductImageWithSlider(product: product),

            /// ----------- [Product Details] -----------------
            Padding(
              padding: UPadding.screenPadding,
              child: Column(
                children: <Widget>[
                  /// ---------[Product Details]---------
                  /// Price, Title, Stock and Brand
                  SizedBox(height: USizes.spaceBtwSections),
                  UProductMetaData(product: product),

                  SizedBox(height: USizes.spaceBtwItems),

                  /// Attributes
                 if(product.productType == ProductType.variable.toString())...[
                   UProductAttributes(product: product),

                   SizedBox(height: USizes.spaceBtwSections),
                 ],

                  /// Checkout Button
                  UElevatedButton(child: Text('Checkout'), onPressed: () {}),

                  SizedBox(height: USizes.spaceBtwSections),

                  /// Description
                  SectionHeading(
                    sectionHeading: 'Description',
                    showActionButton: false,
                  ),
                  SizedBox(height: USizes.spaceBtwItems),

                  ReadMoreText(
                    product.description ?? '',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Show more',
                    trimExpandedText: ' Less',
                    moreStyle:  TextStyle(fontSize: 14.0, fontWeight: FontWeight.w800),
                    lessStyle:  TextStyle(fontSize: 14.0, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: USizes.spaceBtwSections),
                ],
              ),
            )
          ],
        ),
      ),

      /// ---------- [Bottom Navigation] -------------
      bottomNavigationBar: UBottomAddToCart(product: product),
    );
  }
}
