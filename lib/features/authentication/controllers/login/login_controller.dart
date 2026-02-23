import 'package:e_commerce/data/repository/authentication_repository.dart';
import 'package:e_commerce/features/personalization/controllers/user_controller.dart';
import 'package:e_commerce/utils/constants/uimages.dart';
import 'package:e_commerce/utils/helpers/network_manager.dart';
import 'package:e_commerce/utils/popup/full_screen_loader.dart';
import 'package:e_commerce/utils/popup/snack_bar_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final _userCredentials = Get.put(UserController());
  final loginKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  RxBool rememberMe = false.obs;
  RxBool isPasswordVisible = false.obs;
  final localStorage = GetStorage();


  @override
  void onInit() {
    super.onInit();

    email.text = localStorage.read('remember_email') ?? '';
    password.text = localStorage.read('remember_password') ?? '';
  }

  // Login Controller Function

  Future<void> login() async {
    try {
      if (!loginKey.currentState!.validate()) return;


      UFullScreenLoader.openLoadingDialog(
        'We are processing your Information',
        UImages.loadingAnimation,
      );

      bool isConnected = await NetworkManager.instannce.isConnected();
      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        SnackBarHelpers.ErrorSnackBar(
          title: 'Error',
          message: 'No Internet Connection',
        );
        return;
      }

      if (rememberMe.value) {
        localStorage.write('remember_email', email.text.trim());
        localStorage.write('remember_password', password.text.trim());
      }

      await AuthenticationRepository.instance.signin(
        email.text.trim(),
        password.text.trim(),
      );

      UFullScreenLoader.stopLoading();

      AuthenticationRepository.instance.screenRedirect();

      Future.delayed(Duration(milliseconds: 200), () {
        SnackBarHelpers.successSnackBar(
          title: 'Congratulations',
          message: 'You are successfully Logged in',
        );
      });
    } catch (e) {
      UFullScreenLoader.stopLoading();
      SnackBarHelpers.ErrorSnackBar(title: 'Error', message: e.toString());
    }
  }

  // Google Signin Controller

  Future<void> googleLogin() async {
    try{

      // Start Loading
      UFullScreenLoader.openLoadingDialog(
          'Logging you in...',
          UImages.loadingAnimation
      );
      // Check Internet Connectivity
      bool isConnected = await NetworkManager.instannce.isConnected();
      if(!isConnected){
        UFullScreenLoader.stopLoading();
        SnackBarHelpers.warningSnackBar(title: 'Warning', message: 'No Internet Connection');
      }

      // Google Authentication
      UserCredential userCredential = await AuthenticationRepository.instance.signInWithGoogle();

      // Save user Record
      await _userCredentials.saveUserRecord(userCredential);

      // Stop loading
      UFullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();

    }catch(e){
      UFullScreenLoader.stopLoading();
      SnackBarHelpers.ErrorSnackBar(title: 'Login Failed', message: e.toString());
    }
  }

}
