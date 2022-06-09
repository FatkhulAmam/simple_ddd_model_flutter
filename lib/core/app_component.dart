
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_provider.dart';
import 'app_route.dart';
import 'app_store_application.dart';
import 'binding.dart';
import 'env.dart';

class AppComponent extends StatelessWidget {
  final AppStoreApplication _application;

  AppComponent(this._application);

  @override
  Widget build(BuildContext context) {
    Get.log(Env.value.appName);

    final myApp = GetMaterialApp(
      debugShowCheckedModeBanner: false,
      enableLog: Env.value.environmentType != EnvType.PRODUCTION,
      getPages: AppRouter.routes,
      initialRoute: AppRouter.INITIAL,
      defaultTransition: Transition.noTransition,
      initialBinding: AppBinding(),
      smartManagement: SmartManagement.keepFactory,
      title: Env.value.appName,
      color: Env.value.primarySwatch,
      themeMode: ThemeMode.light,
    );

    final appProvider =
    AppProvider(child: myApp, application: _application);
    return appProvider;
  }

}