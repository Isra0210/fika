import 'dart:async';

import 'package:fika/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'src/data/storage/local_storage.dart';
import 'src/my_app.dart';

Future<void> main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp],
      );
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      await LocalStorage().init();
      runApp(const MyApp());
    },
    handleError,
  );
}

void handleError(Object error, StackTrace stack) {
  FirebaseCrashlytics.instance.recordError(
    error,
    stack,
    fatal: true,
  );
}
