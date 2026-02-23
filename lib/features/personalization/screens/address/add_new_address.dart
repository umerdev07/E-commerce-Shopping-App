import 'package:e_commerce/common/styles/u_padding.dart';
import 'package:e_commerce/common/widgets/button/u_elevatedbutton.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/validators/validations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../controllers/add_new_address_controller.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddNewAddressController());
    return Scaffold(
      /// ---- [AppBar] ----
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          "Add new Address",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),

      /// ---- [Body] -----
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Form(
            key: controller.addressFoamKey,
            child: Column(
              children: [
                SizedBox(height: USizes.spaceBtwSections),

                TextFormField(
                  // Name
                  controller: controller.name,
                  validator: (value) => UValidations.validationEmptyText('Name', value),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: 'Name',
                  ),
                ),

                SizedBox(height: USizes.spaceBtwInputFields),

                TextFormField(
                  // Phone Number
                  controller: controller.phoneNumber,
                  validator: (value) => UValidations.validationEmptyText('Name', value),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.mobile),
                    labelText: 'Phone Number',
                  ),
                ),

                SizedBox(height: USizes.spaceBtwInputFields),

                Row(
                  children: [
                    // Street
                    Expanded(
                      child: TextFormField(
                        controller: controller.street,
                        validator: (value) => UValidations.validationEmptyText('Street', value),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.building_3),
                          labelText: 'Street',
                        ),
                      ),
                    ),
                    SizedBox(width: USizes.spaceBtwInputFields),

                    // Postal Code
                    Expanded(
                      child: TextFormField(
                        validator: (value) => UValidations.validationEmptyText('Postal Code', value),
                        controller: controller.postalCode,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.code),
                          labelText: 'Postal Code',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: USizes.spaceBtwInputFields),

                Row(
                  children: [
                    // Street
                    Expanded(
                      child: TextFormField(
                        validator: (value) => UValidations.validationEmptyText('City', value),
                        controller: controller.city,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.building),
                          labelText: 'City',
                        ),
                      ),
                    ),
                    SizedBox(width: USizes.spaceBtwInputFields),

                    // Postal Code
                    Expanded(
                      child: TextFormField(
                        validator: (value) => UValidations.validationEmptyText('State', value),
                        controller: controller.state,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.activity),
                          labelText: 'State',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: USizes.spaceBtwInputFields),

                TextFormField(
                  // Country
                  validator: (value) => UValidations.validationEmptyText('Country', value),
                  controller: controller.country,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.global),
                    labelText: 'Country',
                  ),
                ),

                SizedBox(height: USizes.spaceBtwSections),
                UElevatedButton(onPressed: controller.addNewAddress, child: Text('Save')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
