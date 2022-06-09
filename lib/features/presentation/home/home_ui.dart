import 'package:dio_demo/features/application/main_services.dart';
import 'package:dio_demo/features/infrastructure/models/main_response.dart';
import 'package:dio_demo/features/presentation/person_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_logic.dart';

class HomeWidget extends StatelessWidget {
  static const String PATH = '/home';
  final logic = Get.find<HomeLogic>();
  final state = Get.find<HomeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeLogic>(
      assignId: true,
      builder: (logic) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Dio Demo'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                state.mainResponse != null
                    ? PersonCard(person: state.mainResponse!)
                    : const Text('no data'),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () async {
                      logic.onGetUser();
                    },
                    child: const Text('GET'),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                      onPressed: () async {logic.onPostUser();},
                      child: const Text('POST')),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
