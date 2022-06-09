
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'app_component.dart';
import 'app_store_application.dart';
import 'dependency_injection.dart';

enum EnvType {
  DEVELOPMENT,
  STAGING,
  PRODUCTION,
  TESTING
}

class Env {

  static late Env value;

  late String appName;
  late String baseUrl;
  late String tnc;
  late Color primarySwatch;
  EnvType environmentType = EnvType.DEVELOPMENT;

  // Database Config
  int? dbVersion = 1;
  String? dbName;

  Env() {
    value = this;
    _init();
  }

  void _init() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    await DenpendencyInjection.init();
    var application = AppStoreApplication();
    await application.onCreate();
    runApp(AppComponent(application));
  }
}