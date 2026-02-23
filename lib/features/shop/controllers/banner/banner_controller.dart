import 'package:e_commerce/data/repository/banner/banner_repository.dart';
import 'package:e_commerce/features/shop/models/banner_model.dart';
import 'package:e_commerce/utils/popup/snack_bar_helpers.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();

  // Variables
  final _bannerRepository = Get.put(BannerRepository());
  RxList<BannerModel> allBanners = <BannerModel>[].obs;
  RxList<BannerModel> isActive = <BannerModel>[].obs;
  RxBool isBannerLoading = false.obs;

  @override
  void onInit() {
    fetchAllBanners();
    super.onInit();
  }

  Future<void> fetchAllBanners() async {
    try {
      // Start Loading
      isBannerLoading.value = true;

      // Get list of banners from repo
      List<BannerModel> banner = await _bannerRepository.fetchBanner();

      // Asign List of banners to and List of banner
      allBanners.assignAll(banner);

    } catch (e) {
      SnackBarHelpers.ErrorSnackBar(title: 'Failed', message: e.toString());
    } finally {
      isBannerLoading.value = false;
    }
  }
}
