// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:unstudio_assignment/themes/app_colors.dart';

import 'package:unstudio_assignment/themes/text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onTap,
    this.icon,
    required this.label,
  });
  final void Function()? onTap;
  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        icon: Icon(
          icon,
          color: AppColors.white,
        ),
        style: ButtonStyle(
            padding: WidgetStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(horizontal: 24, vertical: 8)),
            backgroundColor: WidgetStatePropertyAll<Color>(AppColors.black),
            shape: WidgetStatePropertyAll<RoundedRectangleBorder>(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ))),
        onPressed: onTap,
        label: Text(
          label,
          style: CustomTextStyles.white14W400,
        ));
  }
}
