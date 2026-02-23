import 'package:e_commerce/common/styles/u_padding.dart';
import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/features/personalization/controllers/add_new_address_controller.dart';
import 'package:e_commerce/features/personalization/models/address_model.dart';
import 'package:e_commerce/features/personalization/screens/address/widgets/single_card_address.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_new_address.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddNewAddressController());
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          "Addreses",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child:
            Obx(
              () => FutureBuilder(
                key: Key(controller.refreshData.value.toString()),
                  future: controller.getAllAddresses(),
                  builder: (context, snapshot) {
              
                    Widget? widget = UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                    if(widget != null) return widget;
              
                    List<AddressModel> address = snapshot.data!;
                    return ListView.separated(
                      shrinkWrap: true,
                        separatorBuilder: (context, index) => SizedBox(height: USizes.spaceBtwItems),
                        itemCount: address.length,
                        itemBuilder: (context, index) {
                          return USingleAddress(
                               address: address[index], onTap: () => controller.updateSelectedAddress(address[index]),
                          );
                        },
                    );
                  },
              ),
            ),

        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddNewAddressScreen()),
        child: Icon(Icons.add),
        backgroundColor: UColors.primary,
      ),
    );
  }
}
