import 'package:fika/src/presentation/controllers/auth/auth_controller.dart';
import 'package:fika/src/presentation/pages/auth/widgets/sign_in_widget.dart';
import 'package:fika/src/presentation/pages/auth/widgets/sign_up_widget.dart';
import 'package:fika/src/presentation/utils/icons/custom_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AuthPage extends GetView<AuthController> {
  const AuthPage({super.key});

  static const route = '/auth';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 120, bottom: 80),
            height: size.height * 0.4,
            width: size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF8805f0),
                  Colors.purple,
                  Color(0xFFb41caf),
                  Color(0xFFe53469),
                ],
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: 60),
              SvgPicture.asset(
                CustomIcons.logo,
                height: 160,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      blurRadius: 8,
                      spreadRadius: 0.4,
                      offset: Offset(0, 4),
                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: GetBuilder<AuthController>(
                  builder: (controller) {
                    return AnimatedCrossFade(
                      firstChild: LoginWidget(),
                      secondChild: SignUpWidget(),
                      crossFadeState: controller.isLogin
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      duration: const Duration(milliseconds: 200),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
