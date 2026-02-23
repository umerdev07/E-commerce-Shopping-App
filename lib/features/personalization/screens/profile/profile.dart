import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/data/repository/authentication_repository.dart';
import 'package:e_commerce/features/personalization/screens/address/address.dart';
import 'package:e_commerce/features/personalization/screens/profile/widgets/profile_header.dart';
import 'package:e_commerce/features/personalization/screens/profile/widgets/profile_title.dart';
import 'package:e_commerce/features/personalization/screens/profile/widgets/setting_menu_title.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../shop/screens/order/order.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            UProfilePrimaryHeader(),

            Padding(
              padding: const EdgeInsets.all(USizes.defaultSpace),
              child: Column(
                children: [
                  UserProfileTitle(),
                  SizedBox(height: USizes.spaceBtwItems),

                  SectionHeading(
                    sectionHeading: 'Account Setting',
                    showActionButton: false,
                  ),

                  ProfileSettingMenu(
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subtitle: 'set delivery address',
                    onTap: () => Get.to(AddressScreen()),
                  ),
                  ProfileSettingMenu(
                    icon: Iconsax.shopping_cart,
                    title: 'My Carts',
                    subtitle: 'Add, remove products and move to checkout',
                    onTap: () {},
                  ),
                  ProfileSettingMenu(
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subtitle: 'In-progress and Completed Orders',
                    onTap: () => Get.to(() => OrderScreen()),
                  ),

                  SizedBox(height: USizes.spaceBtwItems),

                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () async {
                        await AuthenticationRepository.instance.logOut();
                      },
                      child: Text(
                        'Logout',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
