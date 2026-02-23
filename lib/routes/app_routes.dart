import 'package:e_commerce/features/authentication/screens/forgetPassword/forgetPassword.dart';
import 'package:e_commerce/features/authentication/screens/onboarding/onboarding.dart';
import 'package:e_commerce/features/personalization/screens/profile/profile.dart';
import 'package:e_commerce/features/shop/screens/checkout/checkout.dart';
import 'package:e_commerce/features/shop/screens/order/order.dart';
import 'package:e_commerce/features/shop/screens/store/store.dart';
import 'package:e_commerce/features/shop/screens/wishlist/wishlist.dart';
import 'package:e_commerce/routes/routes.dart';
import 'package:get/get.dart';

import '../features/authentication/screens/login/login.dart';
import '../features/authentication/screens/signup/signup.dart';
import '../features/authentication/screens/signup/verify_email.dart';
import '../features/personalization/screens/address/address.dart';
import '../features/personalization/screens/edit_profile/editProfile.dart';
import '../features/shop/screens/cart/cart.dart';
import '../navigationMenu.dart';

class UAppRoutes {
  static final screens = [
    GetPage(name: URoutes.home, page: () => const NavigationMenu()),
    GetPage(name: URoutes.store, page: () => const StoreScreen(),),
    GetPage(name: URoutes.wishlist, page: () => const WishListScreen(),),
    GetPage(name: URoutes.profile, page: () => const ProfileScreen(),),
    GetPage(name: URoutes.order, page: () => const OrderScreen(),),
    GetPage(name: URoutes.checkout, page: () => const CheckoutScreen(),),
    GetPage(name: URoutes.cart, page: () => const CartScreen(),),
    GetPage(name: URoutes.editProfile, page: () => const EditProfileScreen(),),
    GetPage(name: URoutes.userAddress, page: () => const AddressScreen(),),
    GetPage(name: URoutes.signup, page: () => const SignupScreen(),),
    GetPage(name: URoutes.verifyEmail, page: () => const VerifyEmailScreen(),),
    GetPage(name: URoutes.signIn, page: () => const LoginScreen(),),
    GetPage(name: URoutes.forgetPassword, page: () => const ForgetpasswordScreen(),),
    GetPage(name: URoutes.onBoarding, page: () => const Onboarding(),),
  ];
}