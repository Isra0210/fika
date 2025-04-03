import 'package:fika/src/data/models/register_model.dart';
import 'package:fika/src/presentation/controllers/auth/auth_controller.dart';
import 'package:fika/src/presentation/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/register_app_bar.dart';

class SetGenderPage extends StatefulWidget {
  const SetGenderPage({super.key});

  static const route = '/set-gender';

  @override
  State<SetGenderPage> createState() => _SetGenderPageState();
}

class _SetGenderPageState extends State<SetGenderPage> {
  final controller = Get.find<AuthController>();

  @override
  void initState() {
    controller.setRegisterStep(controller.storage.getRegisterStep);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: RegisterAppBar(
        onActionPressed: () {
          if (controller.registerStep?.genderType == null) {
            return CustomSnackbar.showError('Selecione seu gênero');
          }
          controller.redirectRegisterStepAsNeeded(controller.user);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Qual é seu gênero?', style: theme.textTheme.titleLarge),
            const SizedBox(height: 30),
            ...GenderType.values.map(
              (type) => Column(
                children: [
                  GetBuilder<AuthController>(builder: (controller) {
                    return InkWell(
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                      onTap: () => controller.setRegisterStep(
                        controller.registerStep!.copyWith(genderType: type),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: type == controller.registerStep!.genderType
                                ? theme.primaryColor
                                : Colors.grey.shade400,
                            width: type == controller.registerStep!.genderType
                                ? 1
                                : 0.6,
                          ),
                        ),
                        child: Text(
                          controller.getGenderTypeName(type),
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: type == controller.registerStep!.genderType
                                ? theme.primaryColor
                                : Colors.grey.shade700,
                            fontWeight:
                                type == controller.registerStep!.genderType
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
