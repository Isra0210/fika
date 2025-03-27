import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomLoading {
  static show() {
    Get.dialog(
      barrierColor: Colors.black.withOpacity(0.4),
      barrierDismissible: false,
      BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5,
          sigmaY: 5,
        ),
        child: Center(
          child: Platform.isIOS
              ? CupertinoActivityIndicator(color: Colors.white)
              : CircularProgressIndicator(color: Colors.white),
        ),
      ),
    );
  }

  static void hidden() => Get.back();
  // {
  // if (Navigator.canPop(context)) Navigator.of(context).pop();
  // }
}
