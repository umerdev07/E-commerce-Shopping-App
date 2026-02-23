import 'package:e_commerce/data/repository/authentication_repository.dart';
import 'package:e_commerce/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'firebase_options.dart';

Future<void> main() async {

  /// Get Storage
  await GetStorage.init();

  /// Widget Flutter Binding
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  /// Flutter Native Splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);


  /// Firebase Initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((onValue){
    Get.put(AuthenticationRepository());
  });

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

