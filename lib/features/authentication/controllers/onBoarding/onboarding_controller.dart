// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../screens/login/login.dart';

class OnboardingController extends GetxController{
    static OnboardingController get instance => Get.find();

    final storage = GetStorage();

    final pageController = PageController();
    final RxInt currentPage = 0.obs;

    void updatePageIndicator(index) {
      currentPage.value = index;
    }

    void dotNavigationClick(index) {
      currentPage.value = index;

      pageController.jumpToPage(index);
    }

    void nextPage() {

      if(currentPage == 2) {
        storage.write('isFirstTime', false);
        Get.offAll(() => LoginScreen());
        return;
      }

      currentPage.value++;
      pageController.jumpToPage(currentPage.value);

    }

    void skipPage() {
      currentPage.value = 2;
      pageController.jumpToPage(currentPage.value);
    }
}