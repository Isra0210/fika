import 'package:fika/src/presentation/controllers/auth/auth_binding.dart';
import 'package:fika/src/presentation/controllers/auth/auth_controller.dart';
import 'package:fika/src/presentation/pages/splash/splash_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Fika',
      debugShowCheckedModeBanner: false,
      initialBinding: AuthBinding(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFFe53469),
          primary: Color(0xFFe53469),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          centerTitle: false,
          titleTextStyle: GoogleFonts.exo2(
            fontSize: 20,
            color: Colors.white,
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        textTheme: TextTheme(
          labelSmall: GoogleFonts.montserrat(fontSize: 8, color: Colors.black),
          labelMedium:
              GoogleFonts.montserrat(fontSize: 10, color: Colors.black),
          labelLarge: GoogleFonts.exo2(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          bodySmall: GoogleFonts.montserrat(fontSize: 12, color: Colors.black),
          bodyMedium: GoogleFonts.montserrat(
            fontSize: 14,
            color: Colors.black,
          ),
          bodyLarge: GoogleFonts.exo2(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          titleSmall: GoogleFonts.montserrat(fontSize: 16, color: Colors.black),
          titleMedium:
              GoogleFonts.montserrat(fontSize: 18, color: Colors.black),
          titleLarge: GoogleFonts.exo2(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          displayMedium: GoogleFonts.exo2(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        useMaterial3: true,
      ),
      initialRoute: SplashPage.route,
      getPages: routes,
      onInit: () async {
        await Future.delayed(const Duration(seconds: 1));
        Get.find<AuthController>().handleUser(
          FirebaseAuth.instance.authStateChanges(),
        );
      },
    );
  }
}
