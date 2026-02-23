import 'package:e_commerce/features/personalization/controllers/add_new_address_controller.dart';
import 'package:e_commerce/features/personalization/models/address_model.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../../common/widgets/custom_shapes/URoundedContainer.dart';
import '../../../../../utils/constants/sizes.dart';

class USingleAddress extends StatelessWidget {
  const USingleAddress({super.key, required this.address, required this.onTap});

  final AddressModel address;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final bool dark = UHelperFunction.isDarkMode(context);
    final controller = AddNewAddressController.instance;
    return Obx(() {
      String selectedAddressId = controller.selectedAddress.value.id;
      bool isSelected = selectedAddressId == address.id;
      return InkWell(
        onTap: onTap,
        child: URoundedContainer(
          width: double.infinity,
          showBorder: true,
          backgroundColor: isSelected
              ? UColors.primary.withValues(alpha: 0.5)
              : Colors.transparent,
          borderColor: isSelected
              ? Colors.transparent
              : dark
              ? UColors.darkerGrey
              : UColors.grey,
          padding: EdgeInsets.all(USizes.md),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  // Name
                  Text(
                    address.name,
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: USizes.spaceBtwItems / 2),

                  // PhoneNumber
                  Text(
                    address.phoneNumber,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: USizes.spaceBtwItems / 2),
                  // Address
                  Text(address.toString()),
                ],
              ),
              if (isSelected)
                Positioned(
                  top: 0,
                  bottom: 0,
                  right: 6,
                  child: Icon(Iconsax.tick_circle),
                ),
            ],
          ),
        ),
      );
    });
  }
}
