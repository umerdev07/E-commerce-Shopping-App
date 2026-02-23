import 'package:e_commerce/features/personalization/controllers/user_controller.dart';
import 'package:e_commerce/features/personalization/screens/edit_profile/editProfile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class UserProfileTitle extends StatelessWidget {
  const UserProfileTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Obx( () => Text(controller.user.value.username, style: Theme.of(context).textTheme.headlineSmall)),
      subtitle: Obx(() => Text(controller.user.value.email, style: Theme.of(context).textTheme.bodyMedium)),
      trailing: IconButton(onPressed: () => Get.to(() => EditProfileScreen()), icon: Icon(Iconsax.edit)),
    );
  }
}
