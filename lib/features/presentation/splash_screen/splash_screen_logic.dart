import 'package:dio_demo/features/presentation/home/home_ui.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import 'splash_screen_state.dart';

class SplashScreenLogic extends GetxController {
  final SplashScreenState state = SplashScreenState();

  @override
  void onInit() {
    super.onInit();
    FlutterNativeSplash.remove();
  }


  @override
  void onReady() async {
    super.onReady();
    await Future.delayed(const Duration(seconds: 3));
    // Get.updateLocale(const Locale('id', 'ID'));
    Get.offNamedUntil(HomeWidget.PATH, (route) => false);
  }
}
