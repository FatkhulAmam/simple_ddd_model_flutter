import 'package:get/get.dart';

import '../app/network/provider/db_provider.dart';
import '../utility/shared/services/storage_service.dart';

class DenpendencyInjection {
  static Future<void> init() async {
    await Get.putAsync(() => StorageService().init());
    await Get.putAsync(() => DBProvider().init());
  }
}