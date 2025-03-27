import 'package:fika/src/presentation/controllers/auth/auth_controller.dart';
import 'package:fika/src/presentation/utils/validators/text_field_validator.dart';
import 'package:fika/src/presentation/widgets/custom_dialog.dart';
import 'package:fika/src/presentation/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpWidget extends GetView<AuthController> {
  const SignUpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final buttonStyle = ButtonStyle(
      overlayColor: WidgetStateProperty.all(
        Colors.grey.shade100,
      ),
    );
    return Form(
      key: controller.signUpFormKey,
      child: Column(
        children: [
          Text(
            'Cadastro',
            style: theme.textTheme.titleLarge!.copyWith(
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 24),
          CustomTextField(
            controller: controller.nameController,
            prefix: Icon(
              CupertinoIcons.person,
              color: Colors.grey.shade400,
            ),
            fillColor: Colors.white,
            hintText: 'Nome',
            borderColor: Colors.grey.shade300,
            validator: (value) => TextFieldValidator.checkMinChar(
              value!,
              minChar: 6,
            ),
          ),
          const SizedBox(height: 16),
          CustomTextField(
            keyboardType: TextInputType.emailAddress,
            controller: controller.emailController,
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
          const SizedBox(height: 16),
          GetBuilder<AuthController>(builder: (controller) {
            return CustomTextField(
              controller: controller.passwordController,
              prefix: Icon(
                CupertinoIcons.lock,
                color: Colors.grey.shade400,
              ),
              minLines: 1,
              maxLines: 1,
              fillColor: Colors.white,
              hintText: 'Senha',
              obscureText: controller.obscureText,
              borderColor: Colors.grey.shade300,
              suffix: InkWell(
                onTap: () {
                  controller.setObscureText(
                    !controller.obscureText,
                  );
                },
                child: Icon(
                  controller.obscureText
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Colors.grey.shade400,
                ),
              ),
              validator: (value) => TextFieldValidator.checkIfEmpty(
                value!,
              ),
            );
          }),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 30),
            width: size.width,
            decoration: BoxDecoration(
              color: Color(0xFFe53469),
              borderRadius: BorderRadius.circular(100),
            ),
            child: TextButton(
              onPressed: () async => await controller.signUp(),
              child: Text(
                'Cadastrar-se',
                style: theme.textTheme.titleSmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  Expanded(child: const CustomDivider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'Ou',
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                  Expanded(child: const CustomDivider()),
                ],
              ),
              const SizedBox(height: 8),
              TextButton(
                style: buttonStyle,
                onPressed: () => controller.setIsLogin(true),
                child: Text(
                  'Entrar',
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: Colors.grey.shade700,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
