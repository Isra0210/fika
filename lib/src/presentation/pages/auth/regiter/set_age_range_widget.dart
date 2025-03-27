import 'package:fika/src/presentation/pages/auth/regiter/set_location_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth/auth_controller.dart';
import 'widgets/register_app_bar.dart';

class SetAgeRangeWidget extends GetView<AuthController> {
  const SetAgeRangeWidget({super.key});

  static const route = '/set-age-range';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: RegisterAppBar(
        onActionPressed: () {
          controller.redirectRegisterStepAsNeeded(controller.user);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selecione a faixa etária',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 30),
            GetBuilder<AuthController>(builder: (controller) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${controller.minAgeRange.toInt()} a ${controller.maxAgeRange.toInt()} anos',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  RangeSlider(
                    values: RangeValues(
                      controller.minAgeRange,
                      controller.maxAgeRange,
                    ),
                    min: 18,
                    max: 100,
                    onChanged: (value) {
                      controller.setAgeRange(value);
                      controller.setRegisterStep(
                        controller.registerStep!.copyWith(
                          minAgeRange: controller.minAgeRange.toInt(),
                          maxAgeRange: controller.maxAgeRange.toInt(),
                        ),
                      );
                    },
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
