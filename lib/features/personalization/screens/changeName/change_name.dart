import 'package:e_commerce/common/styles/u_padding.dart';
import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/common/widgets/button/u_elevatedbutton.dart';
import 'package:e_commerce/features/personalization/controllers/change_name_controller.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/texts.dart';
import 'package:e_commerce/utils/validators/validations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ChangeNameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangeNameController());
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          'Change Name',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: UPadding.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Update your name to keep your profile accurate and personalized',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(height: USizes.spaceBtwSections),

            Form(
              key: controller.changeNameKey,
              child: Column(
                children: [
                  // First Name
                  TextFormField(
                    controller: controller.firstName,
                    validator: (value) => UValidations.validationEmptyText('First Name', value),
                    decoration: InputDecoration(labelText: UTexts.firstName, prefixIcon: Icon(Iconsax.user)),
                  ),
                  SizedBox(height: USizes.spaceBtwItems),

                  // Last Name
                  TextFormField(
                    controller: controller.lastName,
                    validator: (value) => UValidations.validationEmptyText('Last Name', value),
                    decoration: InputDecoration(labelText: UTexts.lastName, prefixIcon: Icon(Iconsax.user)),
                  ),

                  SizedBox(height: USizes.spaceBtwSections),

                  UElevatedButton(onPressed:  controller.updateName, child: Text('Save'))
                ],
              ),
            )


          ],
        ),
      ),
    );
  }
}
