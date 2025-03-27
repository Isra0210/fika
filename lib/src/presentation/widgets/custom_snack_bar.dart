import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const kSmallSize = 6.0;
const kDefaultSize = 8.0;

class CustomSnackbar {
  // CustomSnackbar.of(this.context);

  // final BuildContext context;

  void notification({
    required String id,
    required String name,
    required String imageUrl,
    required String title,
    required String description,
  }) {
    // final theme = Theme.of(context);
    Get.snackbar(
      '',
      '',
      margin: const EdgeInsets.symmetric(horizontal: 8),
      onTap: (snack) {
        // AppNavigator.of(context).toNamed(NotificationPage.route);
      },
      padding: EdgeInsets.zero,
      messageText: const SizedBox(),
      titleText: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            image: imageUrl.isEmpty
                ? null
                : DecorationImage(image: NetworkImage(imageUrl)),
            // color: generateBackgroundColor(name),
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          // child: Text(
          //   getInitials(name),
          //   style: theme.textTheme.titleMedium!
          //       .copyWith(color: theme.scaffoldBackgroundColor),
          // ),
        ),
        title: Text(title),
        subtitle: Text(description),
        trailing: const Text('Agora'),
      ),
    );
  }

  static void showSuccess(String message, {Color? textColor}) {
    return _showCustomSnackBar(
      message,
      icon: Icon(
        CupertinoIcons.check_mark_circled_solid,
        color: Colors.green,
      ),
    );
  }

  static void showWarning(String message, {Color? textColor}) {
    return _showCustomSnackBar(
      message,
      icon: Icon(
        CupertinoIcons.exclamationmark_triangle_fill,
        color: Colors.amber.shade700,
      ),
    );
  }

  static void showError(String message, {Color? textColor}) {
    return _showCustomSnackBar(
      message,
      icon: Icon(
        CupertinoIcons.xmark_circle_fill,
        color: Colors.red,
      ),
    );
  }

  static void _showCustomSnackBar(
    String text, {
    required Icon icon,
    Color? colorText,
  }) {
    Get.snackbar(
      '',
      '',
      icon: icon,
      backgroundColor: Colors.black54,
      titleText: const SizedBox(),
      messageText: Padding(
        padding: const EdgeInsets.only(bottom: kDefaultSize),
        child: Text(
          text,
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: colorText ?? Colors.white,
          ),
        ),
      ),
      snackStyle: SnackStyle.FLOATING,
      colorText: colorText ?? Colors.white,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(
        left: kSmallSize,
        right: kSmallSize,
        top: kDefaultSize,
      ),
      borderRadius: kSmallSize,
    );
  }
}
