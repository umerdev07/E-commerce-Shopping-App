import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {


  static HomeController get instance => Get.find();

  /// Variables
  final CarouselSliderController carouselController = CarouselSliderController();
  RxInt currentBanner = 0.obs;

  /// Functions
  void onPageChange(int index) {
     currentBanner.value = index;
  }

  void onDotIndicator(int index){
    currentBanner.value = index;
    carouselController.jumpToPage(currentBanner.value);
  }
}