import 'package:get/get.dart';
import 'package:logging/logging.dart';

import '../utility/framework/application.dart';
import '../utility/log/log.dart';
import 'env.dart';

class AppStoreApplication implements Application {

  @override
  Future<void> onCreate() async {
    _initLog();
  }

  void _initLog() {
    Log.init();

    switch(Env.value.environmentType){
      case EnvType.TESTING:
      case EnvType.DEVELOPMENT:
      case EnvType.STAGING:{
        Log.setLevel(Level.ALL);
        break;
      }
      case EnvType.PRODUCTION:{
        Log.setLevel(Level.INFO);
        break;
      }
    }
  }

  @override
  Future<void> onTerminate() async {
    Get.log('''
=============================================================
               APP KILLED
=============================================================
''');
  }
}