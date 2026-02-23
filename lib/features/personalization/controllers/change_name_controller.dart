import 'package:e_commerce/data/repository/user/user_repository.dart';
import 'package:e_commerce/features/personalization/controllers/user_controller.dart';
import 'package:e_commerce/navigationMenu.dart';
import 'package:e_commerce/utils/constants/uimages.dart';
import 'package:e_commerce/utils/helpers/network_manager.dart';
import 'package:e_commerce/utils/popup/full_screen_loader.dart';
import 'package:e_commerce/utils/popup/snack_bar_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangeNameController extends GetxController {
  static ChangeNameController get instance => Get.find();

  final _userController = UserController.instance;
  final _userRepository = UserRepository.instance;

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final changeNameKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializedName();
    super.onInit();
  }

  void initializedName() {
    firstName.text = _userController.user.value.firstName;
    lastName.text = _userController.user.value.lastName;
  }

  Future<void> updateName() async {
    try {
      // Start Loading
      UFullScreenLoader.openLoadingDialog(
        'We are updating your information',
        UImages.loadingAnimation,
      );

      // Check Internet Connectivity
      final bool isConnected = await NetworkManager.instannce.isConnected();
      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        SnackBarHelpers.warningSnackBar(
          title: 'Warning',
          message: 'No Internet',
        );
        return;
      }

      // Foam Validation
      if (!changeNameKey.currentState!.validate()) ;

      // Update User name from firestore
      await _userRepository.updateSingleFieldUserData({
        'FirstName': firstName.text,
        'LastName': lastName.text,
      });

      // Update User name from RX
      _userController.user.value.firstName = firstName.text;
      _userController.user.value.lastName = lastName.text;


      // Stop Laoading
      UFullScreenLoader.stopLoading();

      Get.offAll(() => NavigationMenu());
      
      SnackBarHelpers.successSnackBar(title: 'Congratulations', message: 'Your name has been updated');
      
    } catch (e) {
      UFullScreenLoader.stopLoading();
      SnackBarHelpers.ErrorSnackBar(
        title: 'Update Name Failed',
        message: e.toString(),
      );
    }
  }
}
