import 'package:e_commerce/common/widgets/images/rounded__image.dart';
import 'package:e_commerce/data/repository/address/address_repository.dart';
import 'package:e_commerce/features/personalization/models/address_model.dart';
import 'package:e_commerce/utils/constants/uimages.dart';
import 'package:e_commerce/utils/helpers/network_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/loader/circular_loader.dart';
import '../../../utils/popup/full_screen_loader.dart';
import '../../../utils/popup/snack_bar_helpers.dart';

class AddNewAddressController extends GetxController {
  static AddNewAddressController get instance => Get.find();

  final _addressRepository = Get.put(AddressRepository());
  Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  RxBool refreshData = false.obs;

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();

  GlobalKey<FormState> addressFoamKey = GlobalKey<FormState>();


  Future<void> addNewAddress() async {
    try {
      if (!addressFoamKey.currentState!.validate()) return;

      // Start Loading
      UFullScreenLoader.openLoadingDialog(
        'We are Processing your information',
        UImages.loadingAnimation,
      );

      // Check Internet Availability
      bool isConnected = await NetworkManager.instannce.isConnected();
      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        SnackBarHelpers.warningSnackBar(title: 'No Internet Connection');
        return;
      }

      // Address Model
      AddressModel addressModel = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        postalCode: postalCode.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        country: country.text.trim(),
        dateTime: DateTime.now(),
        selectedAddress: false,
      );

      // Save Address
      String addressId = await _addressRepository.uploadAddress(addressModel);

      // update address id
      addressModel.id = addressId;

      // update selected address
      selectedAddress(addressModel);

      UFullScreenLoader.stopLoading();

      SnackBarHelpers.successSnackBar(
        title: 'Congratulation',
        message: 'Your address save Successfully',
      );

      // Refresh Address data

      refreshData.toggle();

      resetFormFields();

      Navigator.pop(Get.context!);
      Navigator.pop(Get.context!);

    } catch (e) {
      UFullScreenLoader.stopLoading();
      SnackBarHelpers.ErrorSnackBar(title: 'Error', message: e.toString());
    }
  }

  Future<List<AddressModel>> getAllAddresses() async {
    try {
      List<AddressModel> address = await _addressRepository.fetchAddress();
      selectedAddress.value = address.firstWhere((address) => address.selectedAddress, orElse: () => AddressModel.empty());
      return address;
    } catch (e) {
      SnackBarHelpers.ErrorSnackBar(title: 'Failed', message: e.toString());
      return [];
    }
  }

  Future<void> updateSelectedAddress(AddressModel newSelectedAddress) async {
    try {
      Get.defaultDialog(
        title: '',
        onWillPop: () async => false,
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        content: UCircularLoader(),
      );

      if(selectedAddress.value.id.isNotEmpty){
        await _addressRepository.updateSelectedAddress(selectedAddress.value.id, false);
      }

      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      await _addressRepository.updateSelectedAddress(selectedAddress.value.id, true);

      Get.back();
    } catch (e) {
      Get.back();
      SnackBarHelpers.ErrorSnackBar(title: 'Failed', message: e.toString());
    }
  }

  void resetFormFields() {
    name.clear();
    city.clear();
    postalCode.clear();
    street.clear();
    state.clear();
    city.clear();
    country.clear();
    phoneNumber.clear();

    addressFoamKey.currentState!.reset();
  }
}
