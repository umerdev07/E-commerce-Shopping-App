import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/common/widgets/favourite/u_favourite.dart';
import 'package:e_commerce/features/shop/controllers/product/image_controller.dart';
import 'package:e_commerce/features/shop/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/images/rounded__image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_function.dart';

class ProductImageWithSlider extends StatelessWidget {
  const ProductImageWithSlider({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunction.isDarkMode(context);
    final controller = Get.put(ImageController());
    List<String> images = controller.getAllProductImages(product);
    return Container(
      color: dark ? UColors.darkerGrey : UColors.light,
      child: Stack(
        children: [
          /// [Image] - Thumbnail
          SizedBox(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(USizes.productImageRadius * 2),
              child: Center(
                child: Obx(
                  () {
                    final image = controller.selectedProductImage.value;
                    return GestureDetector(
                      onTap: () => controller.showEnlargeImage(image),
                      child: CachedNetworkImage(
                        imageUrl: image,
                        progressIndicatorBuilder: (context, url, progress) =>
                            CircularProgressIndicator(
                              color: UColors.primary,
                              value: progress.progress,
                            ),
                      ),
                    );
                  }
                ),
              ),
            ),
          ),

          /// Image Slider
          Positioned(
            left: USizes.defaultSpace,
            bottom: 30,
            right: 0,
            child: SizedBox(
              height: 80,
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    SizedBox(width: USizes.spaceBtwItems),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (BuildContext context, int index) => Obx( () {
                  bool isProductSelected = controller.selectedProductImage.value == images[index];
                  return  URoundedImage(
                    width: 80,
                    backgroundColor: dark ? UColors.dark : UColors.white,
                    padding: EdgeInsets.all(USizes.sm),
                    border: BoxBorder.all(color: isProductSelected ?  UColors.primary : Colors.transparent),
                    imageUrl: images[index],
                    onPressed: () => controller.selectedProductImage.value =  images[index],
                    isNetworkImage: true,
                  );
                }
                ),
              ),
            ),
          ),

          UAppBar(
            showBackArrow: true,
            actions: [
             UFavouriteIcon(productId: product.id)
            ],
          ),
        ],
      ),
    );
  }
}
