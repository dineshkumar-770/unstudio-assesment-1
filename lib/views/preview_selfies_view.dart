import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unstudio_assignment/providers/registered_providers.dart';
import 'package:unstudio_assignment/routes/app_routes_names.dart';
import 'package:unstudio_assignment/themes/app_colors.dart';
import 'package:unstudio_assignment/themes/text_styles.dart';
import 'package:unstudio_assignment/utils/common/custom_button.dart';

class PreviewSelfiesView extends StatelessWidget {
  const PreviewSelfiesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        automaticallyImplyLeading: false,
        title: Text(
          "Preview Selfies",
          style: CustomTextStyles.black14W400,
        ),
      ),
      body: PopScope(
        canPop: false,
        child: Consumer(builder: (context, ref, _) {
          final previewState = ref.watch(appStateNotifierProvider);
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                    child: GridView.builder(
                  itemCount: previewState.capturedSelfies.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 3 / 4, crossAxisSpacing: 10, mainAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(image: FileImage(File(previewState.capturedSelfies[index])))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () async {
                              Navigator.pop(context);
                              await Future.delayed(const Duration(milliseconds: 400));
                              if (context.mounted) {
                                ref
                                    .read(appStateNotifierProvider.notifier)
                                    .takeSelfies(context: context, retakeIndex: index);
                              }
                            },
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: AppColors.backgroundColor,
                              child: Center(
                                child: Icon(Icons.close),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: SizedBox(
                      width: double.maxFinite,
                      child: CustomButton(
                        label: "Confirm Images",
                        icon: Icons.check_circle,
                        onTap: () {
                          ref.read(appStateNotifierProvider.notifier).fetchAllGarments();
                          Navigator.pushReplacementNamed(context, AppRoutesNames.homeView);
                        },
                      )),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
