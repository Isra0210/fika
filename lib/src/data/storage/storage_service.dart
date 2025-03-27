import 'package:fika/src/data/models/register_model.dart';
import 'package:get/get.dart';

import '../../presentation/utils/constants/keys.dart';
import '../models/user_model.dart';
import 'local_storage.dart';

class StorageService {
  StorageService({required this.storage});
  final LocalStorage storage;

  static const logHeader = '[StorageService]';

  bool get isFirstTime {
    final isFirstTime = storage.getBool(kIsFirstTime);
    Get.log('$logHeader Get isFirstTime => [$isFirstTime]');
    if (isFirstTime == null) return false;
    return isFirstTime;
  }

  Future<void> setIsFirstTime() async {
    Get.log('$logHeader Set isFirstTime => [true]');
    await storage.saveItem<bool>(kIsFirstTime, true);
  }

  UserModel? get user {
    final user = storage.getItem(kCurrentUser);
    if (user == null) return null;
    return UserModel.fromStorageMap(user);
  }

  Future<void> setUser(UserModel user) async {
    final map = user.toStorageMap();
    await storage.saveItem(kCurrentUser, map);
  }

  RegisterModel? get getRegisterStep {
    final step = storage.getItem(kRegisterStep);
    if (step == null) return null;
    return RegisterModel.fromMap(step);
  }

  Future<void> setRegisterStep(RegisterModel step) async {
    final map = step.toMap();
    await storage.saveItem(kRegisterStep, map);
  }
}
