import 'package:fika/src/presentation/pages/auth/regiter/set_age_range_widget.dart';
import 'package:fika/src/presentation/pages/auth/regiter/set_birthdate_page.dart';
import 'package:fika/src/presentation/pages/auth/regiter/set_choice_setup_app.dart';
import 'package:fika/src/presentation/pages/auth/regiter/set_gender_page.dart';
import 'package:fika/src/presentation/pages/auth/regiter/set_looking_for_widget.dart';
import 'package:fika/src/presentation/pages/auth/regiter/set_max_distance_widget.dart';
import 'package:fika/src/presentation/pages/auth/regiter/set_location_widget.dart';
import 'package:fika/src/presentation/pages/splash/splash_page.dart';
import 'package:get/get.dart';

import '../presentation/pages/auth/auth_page.dart';
import '../presentation/pages/home/home_page.dart';

final routes = [
  GetPage(name: SplashPage.route, page: () => SplashPage()),
  GetPage(name: AuthPage.route, page: () => AuthPage()),
  GetPage(name: HomePage.route, page: () => HomePage()),
  GetPage(name: SetGenderPage.route, page: () => SetGenderPage()),
  GetPage(name: SetBirthdatePage.route, page: () => SetBirthdatePage()),
  GetPage(name: SetLookingForWidget.route, page: () => SetLookingForWidget()),
  GetPage(name: SetAgeRangeWidget.route, page: () => SetAgeRangeWidget()),
  GetPage(name: SetMaxDistanceWidget.route, page: () => SetMaxDistanceWidget()),
  GetPage(name: SetChoiceSetupApp.route, page: () => SetChoiceSetupApp()),
  GetPage(name: SetLocationWidget.route, page: () => SetLocationWidget()),
];
