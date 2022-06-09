import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'splash_screen_logic.dart';

class SplashScreenWidget extends StatelessWidget {
  static const String PATH = '/splash';
  final logic = Get.find<SplashScreenLogic>();
  final state = Get.find<SplashScreenLogic>().state;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Dio DDD Model'),
      ),
    );
  }
}
