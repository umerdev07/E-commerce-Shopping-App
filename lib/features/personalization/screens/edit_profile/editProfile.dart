import 'package:e_commerce/common/styles/u_padding.dart';
import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/personalization/controllers/user_controller.dart';
import 'package:e_commerce/features/personalization/screens/changeName/change_name.dart';
import 'package:e_commerce/features/personalization/screens/edit_profile/widgets/edit_profile_logo_with_icon.dart';
import 'package:e_commerce/features/personalization/screens/edit_profile/widgets/user_detail_row.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final conroller = UserController.instance;
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          'Edit Profile',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              UEditProfileLogoWithEditIcon(),

              SizedBox(height: USizes.spaceBtwSections),

              Divider(),

              SizedBox(height: USizes.spaceBtwItems),

              SectionHeading(
                sectionHeading: 'Account Settings',
                showActionButton: false,
              ),

              /// Profile Account Setting
              SizedBox(height: USizes.spaceBtwItems),

              UserDetailRow(title: 'Name', value: conroller.user.value.fullName, onTap: () => Get.to(ChangeNameScreen())),
              UserDetailRow(
                title: 'Username',
                value: conroller.user.value.username,
                onTap: () {},
              ),
              SizedBox(height: USizes.spaceBtwItems),

              Divider(),

              SizedBox(height: USizes.spaceBtwItems),

              /// Profile Section Heading
              SectionHeading(
                sectionHeading: 'Profile Settings',
                showActionButton: false,
              ),

              /// Profile Section Heading
              SizedBox(height: USizes.spaceBtwItems),

              UserDetailRow(title: 'User ID', value: conroller.user.value.id, onTap: () {}),
              UserDetailRow(
                title: 'Email',
                value: conroller.user.value.email,
                onTap: () {},
              ),
              UserDetailRow(
                title: 'Phone Number',
                value: '+92 ${conroller.user.value.phoneNumber}',
                onTap: () {},
              ),
              UserDetailRow(title: 'Gender', value: 'Male', onTap: () {}),

              SizedBox(height: USizes.spaceBtwItems),

              Divider(),
              SizedBox(height: USizes.spaceBtwItems),

              TextButton(
                onPressed: conroller.deleteAccountWarningPopup,
                child: Text(
                  'Close Account',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

