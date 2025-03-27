import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fika/src/data/models/register_model.dart';
import 'package:fika/src/presentation/pages/auth/auth_page.dart';
import 'package:fika/src/presentation/pages/auth/regiter/set_birthdate_page.dart';
import 'package:fika/src/presentation/pages/auth/regiter/set_choice_setup_app.dart';
import 'package:fika/src/presentation/pages/auth/regiter/set_location_widget.dart';
import 'package:fika/src/presentation/pages/auth/regiter/set_looking_for_widget.dart';
import 'package:fika/src/presentation/pages/auth/regiter/set_max_distance_widget.dart';
import 'package:fika/src/presentation/pages/home/home_page.dart';
import 'package:fika/src/presentation/widgets/custom_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../data/models/user_model.dart';
import '../../../data/service/auth/auth_service.dart';
import '../../../data/storage/storage_service.dart';
import '../../pages/auth/regiter/set_age_range_widget.dart';
import '../../pages/auth/regiter/set_gender_page.dart';
import '../../widgets/custom_loading.dart';

class AuthController extends GetxController {
  final storage = Get.find<StorageService>();
  final _service = Get.find<AuthService>();

  bool obscureText = true;
  bool isLogin = true;
  RegisterModel? registerStep;
  double maxDistance = 2.0;
  double minAgeRange = 18.0;
  double maxAgeRange = 32.0;
  PermissionStatus? permissionStatus;

  final Rx<UserModel?> _user = Rx(null);
  UserModel? get user => _user.value ?? getUserFromStorage();
  set user(UserModel? value) => _user.value = value;

  final signInFormKey = GlobalKey<FormState>();
  final signUpFormKey = GlobalKey<FormState>();
  final formRecoveryPasswordKey = GlobalKey<FormState>();
  final emailRecoveryPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController(text: 'teste@gmail.com');
  late final birthdateController = TextEditingController(
    text: registerStep?.birthday == null ? '' : registerStep!.birthday,
  );
  final passwordController = TextEditingController(text: 'teste123');

  void setMaxDistance(double value) {
    maxDistance = value;
    update();
  }

  void setAgeRange(RangeValues range) {
    minAgeRange = range.start;
    maxAgeRange = range.end;
    update();
  }

  void setObscureText(bool value) {
    obscureText = value;
    update();
  }

  void setIsLogin(bool value) {
    isLogin = value;
    update();
  }

  Future<void> setRegisterStep(RegisterModel? step) async {
    registerStep = step ?? RegisterModel();
    await storage.setRegisterStep(registerStep!);
    update();
  }

  void setPermissionStatus(PermissionStatus status) {
    permissionStatus = status;
    update();
  }

  UserModel? getUserFromStorage() => storage.user;

  Future<void> saveUserToStorage(UserModel? user) async {
    if (user == null) return;
    await storage.setUser(user);
  }

  String getGenderTypeName(GenderType type) {
    return switch (type) {
      GenderType.man => 'Homem',
      GenderType.woman => 'Mulher',
      GenderType.nonBinary => 'Não binário',
      _ => 'Outro'
    };
  }

  String getGenderTypeLookingForName(GenderTypeLookingFor type) {
    return switch (type) {
      GenderTypeLookingFor.man => 'Homem',
      GenderTypeLookingFor.woman => 'Mulher',
      _ => 'Todos'
    };
  }

  String getChoiceSetupAppName(ChoiceSetupApp type) {
    return switch (type) {
      ChoiceSetupApp.movie => '',
      _ => 'Restaurantes',
    };
  }

  String? validateDate() {
    if (birthdateController.text.isEmpty) {
      return "Informe sua data de nascimento";
    }

    try {
      DateTime parsedDate =
          DateFormat('dd/MM/yyyy').parseStrict(birthdateController.text);

      if (parsedDate.isAfter(DateTime.now())) {
        return "A data não pode estar no futuro";
      }
      if (parsedDate.isBefore(DateTime(1940))) {
        return "A data deve ser maior que 01/01/1940";
      }
    } catch (e) {
      return "Selecione uma data válida";
    }

    return null;
  }

  Future<void> requestLocationPermission() async {
    final status = await Permission.location.request();
    setPermissionStatus(status);

    // if (status.isGranted) {
    // final position = await Geolocator.getCurrentPosition();
    // setRegisterStep(registerStep!.copyWith(position: position));
    Get.offAllNamed(HomePage.route);
    // }
  }

  void updateUserModel(UserModel? userModel) {
    if (userModel == null) return;
    _user.value = userModel;
  }

  Future<void> onRecoveryPassword() async {
    if (!formRecoveryPasswordKey.currentState!.validate()) return;
    Get.back();
    CustomSnackbar.showSuccess('E-mail enviado');
    formRecoveryPasswordKey.currentState!.reset();
  }

  Future<void> deleteUserAccount() async {
    if (user == null) return;
    await _service.deleteUserAccount(user!);
  }

  Future<void> signUp() async {
    if (!signUpFormKey.currentState!.validate()) return;

    await CustomLoading.show();

    final userModel = UserModel(
      id: '',
      name: nameController.text,
      email: emailController.text.replaceAll(' ', ''),
      createdAt: Timestamp.fromDate(DateTime.now()),
    );

    final signUpOrError = await _service.signUp(
      user: userModel,
      password: passwordController.text,
    );

    CustomLoading.hidden();

    signUpOrError.fold(
      (error) => CustomSnackbar.showError(error),
      (userModel) {
        updateUserModel(userModel);
        redirectRegisterStepAsNeeded(userModel);
      },
    );
  }

  Future<void> signIn() async {
    if (!signInFormKey.currentState!.validate()) return;
    CustomLoading.show();
    final userOrError = await _service.signIn(
      email: emailController.text.trim(),
      password: passwordController.text,
      onError: CustomSnackbar.showError,
    );

    CustomLoading.hidden();

    userOrError.fold(
      (error) => CustomSnackbar.showError(error),
      (userModel) {
        redirectRegisterStepAsNeeded(userModel);
      },
    );
  }

  Future<void> signOut() async {
    await _service.signOut();
  }

  Future<UserModel?> getUserFromFirebase(
    String? userId, {
    UserModel? userModel,
  }) async {
    String? id = userId ?? FirebaseAuth.instance.currentUser?.uid;
    if (id == null) return null;

    final user = await _service.getUserInfo(id);
    _user.value = user;
    await saveUserToStorage(user);
    updateUserModel(user);
    return user;
  }

  Future<void> updateUserInfo() async {
    if (user == null || registerStep == null) return;
    await CustomLoading.show();
    final birthdate = DateFormat('dd/MM/yyyy').parse(registerStep!.birthday!);
    final userUpdated = user!.copyWith(
      birthday: Timestamp.fromDate(birthdate),
      choiceSetupApp: registerStep!.choiceSetupApp,
      genderType: registerStep!.genderType,
      genderTypeLookingFor: registerStep!.genderTypeLookingFor,
      maxAgeRange: maxAgeRange.toInt(),
      minAgeRange: minAgeRange.toInt(),
      maxDistance: maxDistance.toInt(),
      latitude: registerStep!.latitude,
      longitude: registerStep!.longitude,
    );

    await _service.updateUserOnCollection(userUpdated);
    CustomLoading.hidden();
    redirectRegisterStepAsNeeded(userUpdated);
  }

  Future<void> redirectRegisterStepAsNeeded(UserModel? userModel) async {
    if (userModel == null) return;
    if (userModel.genderType == null) {
      return Get.toNamed(SetGenderPage.route);
    }
    if (userModel.birthday == null) {
      return Get.toNamed(SetBirthdatePage.route);
    }
    if (userModel.genderTypeLookingFor == null) {
      return Get.toNamed(SetLookingForWidget.route);
    }
    if (userModel.maxDistance == null) {
      return Get.toNamed(SetMaxDistanceWidget.route);
    }
    if (userModel.minAgeRange == null || userModel.maxAgeRange == null) {
      return Get.toNamed(SetAgeRangeWidget.route);
    }
    if (userModel.latitude == null || userModel.longitude == null) {
      return Get.toNamed(SetLocationWidget.route);
    }
    if (userModel.choiceSetupApp == null) {
      return Get.toNamed(SetChoiceSetupApp.route);
    }
    return handleUser(FirebaseAuth.instance.authStateChanges());
  }

  void handleUser(Stream<User?> stream) async {
    stream.listen(
      (user) async {
        if (user == null) {
          return Get.offAllNamed(AuthPage.route);
        } else {
          if (Get.currentRoute != HomePage.route) {
            Get.offAllNamed(HomePage.route);
          }
        }
      },
    );
  }
}
