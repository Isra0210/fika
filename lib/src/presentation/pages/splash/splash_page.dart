import 'package:flutter/material.dart';

import '../../utils/icons/custom_icons.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static const route = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Image.asset(CustomIcons.logoJpg)));
  }
}
