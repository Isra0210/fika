import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({this.color, this.thickness = 1, super.key});

  final Color? color;
  final double thickness;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? Colors.grey.shade300,
      height: 1,
      thickness: thickness,
    );
  }
}
