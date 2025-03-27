import 'package:fika/src/presentation/pages/auth/regiter/set_max_distance_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/register_model.dart';
import '../../../controllers/auth/auth_controller.dart';
import '../../../widgets/custom_snack_bar.dart';
import 'widgets/register_app_bar.dart';

class SetLookingForWidget extends GetView<AuthController> {
  const SetLookingForWidget({super.key});

  static const route = '/set-looking-for';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: RegisterAppBar(
        onActionPressed: () {
          if (controller.registerStep?.genderType == null) {
            return CustomSnackbar.showError('Selecione uma opção');
          }

          controller.redirectRegisterStepAsNeeded(controller.user);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'O que você gostaria de ver?',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 30),
            ...GenderTypeLookingFor.values.map(
              (type) => Column(
                children: [
                  GetBuilder<AuthController>(builder: (controller) {
                    return InkWell(
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                      onTap: () => controller.setRegisterStep(
                        controller.registerStep!.copyWith(
                          genderTypeLookingFor: type,
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: type ==
                                    controller
                                        .registerStep!.genderTypeLookingFor
                                ? theme.primaryColor
                                : Colors.grey.shade400,
                            width: type ==
                                    controller
                                        .registerStep!.genderTypeLookingFor
                                ? 1
                                : 0.6,
                          ),
                        ),
                        child: Text(
                          controller.getGenderTypeLookingForName(type),
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: type ==
                                    controller
                                        .registerStep!.genderTypeLookingFor
                                ? theme.primaryColor
                                : Colors.grey.shade700,
                            fontWeight: type ==
                                    controller
                                        .registerStep!.genderTypeLookingFor
                                ? FontWeight.bold
                                : FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
