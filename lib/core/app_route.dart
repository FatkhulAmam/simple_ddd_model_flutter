import 'package:dio_demo/features/presentation/home/home_binding.dart';
import 'package:dio_demo/features/presentation/home/home_ui.dart';
import 'package:dio_demo/features/presentation/splash_screen/splash_screen_binding.dart';
import 'package:dio_demo/features/presentation/splash_screen/splash_screen_ui.dart';
import 'package:get/get.dart';

class AppRouter {
  static const INITIAL = SplashScreenWidget.PATH;

  static final routes = [
    GetPage(
      name: SplashScreenWidget.PATH,
      page: () => SplashScreenWidget(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: HomeWidget.PATH,
      page: () => HomeWidget(),
      binding: HomeBinding(),
    ),
  ];
}
