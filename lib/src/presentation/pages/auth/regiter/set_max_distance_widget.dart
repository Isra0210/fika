import 'package:fika/src/presentation/controllers/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/register_app_bar.dart';

class SetMaxDistanceWidget extends GetView<AuthController> {
  const SetMaxDistanceWidget({super.key});

  static const route = '/set-max-distance';

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
              'Selecione a distância máxima',
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
                        '${controller.maxDistance.toInt()} km',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  Slider.adaptive(
                    value: controller.maxDistance,
                    min: 2,
                    max: 150,
                    onChanged: (value) {
                      controller.setMaxDistance(value);
                      controller.setRegisterStep(
                        controller.registerStep!.copyWith(
                          maxDistance: value.toInt(),
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
