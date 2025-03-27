import 'package:fika/src/data/storage/local_storage.dart';
import 'package:fika/src/data/storage/storage_service.dart';
import 'package:get/get.dart';

import '../../../data/service/auth/auth_service.dart';
import 'auth_controller.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(StorageService(storage: LocalStorage()));
    Get.put(AuthService());
    Get.put(AuthController());
  }
}
