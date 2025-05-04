import 'package:flutter/material.dart';
import 'package:unstudio_assignment/models/all_garments_data_model.dart';
import 'package:unstudio_assignment/themes/app_colors.dart';
import 'dart:math' as math;

class SelectedGarmentsWidegt extends StatelessWidget {
  const SelectedGarmentsWidegt({super.key, required this.bottomGarment, required this.topGarments});
  final Garment bottomGarment;
  final Garment topGarments;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 30,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationZ(-10 * math.pi / 180),
          child: Container(
            height: 100,
            width: 70,
            decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 20,
                      blurStyle: BlurStyle.outer,
                      color: Colors.black54.withValues(alpha: 0.2),
                      spreadRadius: 1)
                ],
                image: topGarments.displayUrl == null
                    ? null
                    : DecorationImage(image: NetworkImage(topGarments.displayUrl ?? ""))),
          ),
        ),
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationZ(10 * math.pi / 180),
          child: Container(
            height: 100,
            width: 70,
            decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 20,
                      blurStyle: BlurStyle.outer,
                      color: Colors.black54.withValues(alpha: 0.2),
                      spreadRadius: 1)
                ],
                image: bottomGarment.displayUrl == null
                    ? null
                    : DecorationImage(image: NetworkImage(bottomGarment.displayUrl ?? ""))),
          ),
        ),
      ],
    );
  }
}
