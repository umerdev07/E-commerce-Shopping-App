import 'package:e_commerce/common/styles/u_padding.dart';
import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/common/widgets/brands/brand_card.dart';
import 'package:e_commerce/common/widgets/layouts/grid_layout.dart';
import 'package:e_commerce/common/widgets/shimmer/verical_product_shimmer.dart';
import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/shop/controllers/brand/brand_controller.dart';
import 'package:e_commerce/features/shop/models/brand_model.dart';
import 'package:e_commerce/features/shop/screens/brands/brand_products.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandController());
    return Scaffold(
      appBar: UAppBar(
        title: Text('Brand', style: Theme.of(context).textTheme.headlineMedium),
        showBackArrow: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              SizedBox(height: USizes.spaceBtwItems),
              SectionHeading(sectionHeading: 'Brands', showActionButton: false),
              SizedBox(height: USizes.spaceBtwSections),
              Obx(() {

                return UGridLayout(
                  mainAxisExtent: 80,
                  itemCount: controller.allBrands.length,
                  itemBuilder: (context, index) {
                    final brand = controller.allBrands[index];
                    return UBrandCard(
                      onTap: () => Get.to(() => BrandProductsScreen(title: brand.name, brand: brand)),
                      brandModel: brand,
                    );
                  }
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
