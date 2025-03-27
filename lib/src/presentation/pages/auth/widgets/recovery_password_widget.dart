import 'dart:ui';

import 'package:fika/src/presentation/controllers/auth/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/validators/text_field_validator.dart';
import '../../../widgets/custom_text_field.dart';

class RecoveryPasswordWidget extends GetView<AuthController> {
  const RecoveryPasswordWidget({super.key});

  static const route = '/recovery-password';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonStyle = ButtonStyle(
      overlayColor: WidgetStateProperty.all(
        Colors.grey.shade100,
      ),
    );
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 5,
        sigmaY: 5,
      ),
      child: AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          'Esqueci minha senha',
          style: theme.textTheme.bodyLarge!.copyWith(
            color: Colors.grey.shade700,
          ),
        ),
        content: Form(
          key: controller.formRecoveryPasswordKey,
          child: Container(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: controller.emailRecoveryPasswordController,
                  prefix: Icon(
                    CupertinoIcons.envelope,
                    color: Colors.grey.shade400,
                  ),
                  fillColor: Colors.white,
                  hintText: 'E-mail',
                  borderColor: Colors.grey.shade300,
                  validator: (value) => TextFieldValidator.checkEmail(
                    value!,
                  ),
                  
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            style: buttonStyle,
            child: Text(
              'Fechar',
              style: theme.textTheme.labelLarge!.copyWith(
                color: Colors.grey.shade700,
              ),
            ),
            onPressed: () => Get.back(),
          ),
          TextButton(
            style: buttonStyle,
            onPressed: controller.onRecoveryPassword,
            child: Text(
              'Enviar',
              style: theme.textTheme.labelLarge!.copyWith(
                color: theme.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
