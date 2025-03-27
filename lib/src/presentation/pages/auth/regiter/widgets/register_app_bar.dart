import 'package:flutter/material.dart';

class RegisterAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RegisterAppBar(
      {this.actionText = 'Próximo', this.onActionPressed, super.key});

  final String actionText;
  final void Function()? onActionPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          TextButton(
            onPressed: onActionPressed,
            child: Text(
              actionText,
              style: theme.textTheme.labelLarge!.copyWith(
                color: theme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
