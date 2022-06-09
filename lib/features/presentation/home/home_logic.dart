import 'dart:math';

import 'package:dio_demo/features/application/main_services.dart';
import 'package:dio_demo/features/infrastructure/models/main_response.dart';
import 'package:get/get.dart';

import 'home_state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();

  randomInt() {
    final int min = 1;
    final int max = 12;
    int selection = min + (Random().nextInt(max-min));
    return selection;
  }

  onGetUser() async {
    var useInt = randomInt();
    MainResponse? result = await Services.getById(useInt);
    if (result != null) {
      state.mainResponse = result;
    }
    update();
  }

  onPostUser() async {
    MainResponse? result =
        await Services.createUser('diorama', 'senja', 'dioramaSenja@reg.res');
    if (result != null) {
      state.mainResponse = result;
    }
    update();
  }
}
