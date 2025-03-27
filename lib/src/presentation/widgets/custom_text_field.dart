import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    this.controller,
    this.labelText,
    this.fillColor,
    this.validator,
    this.suffix,
    this.hintText,
    this.inputFormatters,
    this.highlightColor,
    this.contentPadding,
    this.maxLenght,
    this.textInputAction,
    this.onFieldSubmitted,
    this.keyboardType,
    //  = TextInputType.multiline,
    this.onChanged,
    this.prefix,
    this.borderWidth = 1.0,
    this.obscureText = false,
    this.maxLines = 4,
    this.minLines = 1,
    this.enabled = true,
    this.useHeight = true,
    this.useBorder = true,
    this.readOnly = false,
    this.focusNode,
    this.labelStyle,
    this.borderRadius,
    this.cursorHeight,
    this.borderColor,
    super.key,
  });

  final bool useBorder;
  final TextEditingController? controller;
  final Color? fillColor;
  final Color? highlightColor;
  final String? labelText;
  final String? hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Widget? suffix;
  final Widget? prefix;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsetsGeometry? contentPadding;
  final int maxLines;
  final int minLines;
  final int? maxLenght;
  final double borderWidth;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final bool enabled;
  final bool useHeight;
  final FocusNode? focusNode;
  final TextStyle? labelStyle;
  final BorderRadius? borderRadius;
  final double? cursorHeight;
  final Color? borderColor;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      readOnly: readOnly,
      cursorHeight: cursorHeight,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      maxLength: maxLenght,
      maxLines: maxLines,
      minLines: minLines,
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      style: theme.textTheme.bodyMedium!.copyWith(
        color: Colors.grey.shade800,
      ),
      inputFormatters: inputFormatters,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      enabled: enabled,
      decoration: InputDecoration(
        contentPadding: contentPadding,
        suffixIcon: suffix,
        prefixIcon: prefix,
        filled: true,
        fillColor: fillColor ?? theme.scaffoldBackgroundColor.withOpacity(0.8),
        hintText: hintText,
        labelText: labelText,
        labelStyle: labelStyle ??
            theme.textTheme.bodyMedium!.copyWith(
              color: Colors.grey.shade500,
            ),
        hintStyle: theme.textTheme.bodyMedium!.copyWith(
          color: Colors.grey.shade500,
        ),
        errorStyle: const TextStyle(fontSize: 10),
        errorBorder: useBorder
            ? OutlineInputBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: highlightColor ?? theme.colorScheme.error,
                  width: borderWidth,
                ),
              )
            : InputBorder.none,
        border: useBorder
            ? OutlineInputBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: borderColor ??
                      highlightColor?.withOpacity(0.6).withOpacity(0.4) ??
                      theme.colorScheme.onSurface.withOpacity(0.6),
                  width: borderWidth,
                ),
              )
            : InputBorder.none,
        disabledBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          borderSide: BorderSide(
            color: borderColor ??
                highlightColor?.withOpacity(0.6) ??
                theme.colorScheme.onSurface.withOpacity(0.4),
            width: borderWidth,
          ),
        ),
        enabledBorder: useBorder
            ? OutlineInputBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: borderColor ??
                      highlightColor?.withOpacity(0.6) ??
                      theme.colorScheme.onSurface.withOpacity(0.4),
                  width: borderWidth,
                ),
              )
            : InputBorder.none,
        focusedBorder: useBorder
            ? OutlineInputBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: theme.primaryColor,
                  width: borderWidth,
                ),
              )
            : InputBorder.none,
      ),
    );
  }
}
