import 'package:fika/src/presentation/controllers/auth/auth_controller.dart';
import 'package:fika/src/presentation/pages/auth/regiter/set_looking_for_widget.dart';
import 'package:fika/src/presentation/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../data/storage/storage_service.dart';
import '../../../widgets/custom_snack_bar.dart';
import 'widgets/register_app_bar.dart';

class SetBirthdatePage extends GetView<AuthController> {
  const SetBirthdatePage({super.key});

  static const route = '/set-birthdate';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: RegisterAppBar(
        onActionPressed: () {
          final errorMessage = controller.validateDate();
          if (errorMessage != null) {
            return CustomSnackbar.showError(errorMessage);
          }
          controller.setRegisterStep(
            controller.registerStep!.copyWith(
              birthday: controller.birthdateController.text,
            ),
          );
          controller.redirectRegisterStepAsNeeded(controller.user);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Quando você nasceu?', style: theme.textTheme.titleLarge),
            const SizedBox(height: 16),
            CustomTextField(
              keyboardType: TextInputType.number,
              controller: controller.birthdateController,
              prefix: Icon(
                CupertinoIcons.calendar,
                color: Colors.grey.shade400,
              ),
              fillColor: Colors.white,
              hintText: 'Ex: 10/02/2000',
              borderColor: Colors.grey.shade300,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                DateTextInputFormatter(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DateTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (digitsOnly.length > 8) return oldValue;

    String formattedDate = '';
    if (digitsOnly.isNotEmpty) {
      formattedDate += digitsOnly.substring(0, digitsOnly.length.clamp(0, 2));
    }
    if (digitsOnly.length > 2) {
      formattedDate +=
          '/${digitsOnly.substring(2, digitsOnly.length.clamp(2, 4))}';
    }
    if (digitsOnly.length > 4) {
      formattedDate +=
          '/${digitsOnly.substring(4, digitsOnly.length.clamp(4, 8))}';
    }

    return TextEditingValue(
      text: formattedDate,
      selection: TextSelection.collapsed(offset: formattedDate.length),
    );
  }
}
