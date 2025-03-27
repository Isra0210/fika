import 'package:fika/src/presentation/controllers/auth/auth_controller.dart';
import 'package:fika/src/presentation/pages/auth/regiter/set_choice_setup_app.dart';
import 'package:fika/src/presentation/utils/icons/custom_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../widgets/custom_snack_bar.dart';
import 'widgets/register_app_bar.dart';

class SetLocationWidget extends GetView<AuthController> {
  const SetLocationWidget({super.key});

  static const route = '/set-location';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: RegisterAppBar(
        actionText: 'Próximo',
        onActionPressed: () {
          if (controller.user?.latitude == null ||
              controller.user?.longitude == null) {
            return CustomSnackbar.showError(
              'Por favor, permita o acesso a localização',
            );
          }
          controller.redirectRegisterStepAsNeeded(controller.user);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Você é daqui?', style: theme.textTheme.titleLarge),
                const SizedBox(height: 16),
                Text(
                  'Defina a localização para ver quem está próximo a você.',
                  style: theme.textTheme.labelMedium,
                ),
              ],
            ),
            Center(
              child: Image.asset(CustomIcons.location, height: 200, width: 200),
            ),
            //TODO
            GetBuilder<AuthController>(builder: (controller) {
              if (controller.permissionStatus == null ||
                  controller.permissionStatus == PermissionStatus.granted) {
                return const SizedBox();
              }

              //botao de permitir -> await controller.requestLocationPermission();
              //se foi negada, botao de abrir configurações
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 30),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFe53469),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: TextButton(
                  onPressed: () => openAppSettings(),
                  child: Text(
                    'Abrir configurações',
                    style: theme.textTheme.titleSmall!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
