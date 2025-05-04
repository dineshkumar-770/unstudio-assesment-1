import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unstudio_assignment/providers/registered_providers.dart';
import 'package:unstudio_assignment/routes/app_routes_names.dart';
import 'package:unstudio_assignment/themes/app_colors.dart';
import 'package:unstudio_assignment/themes/text_styles.dart';
import 'package:unstudio_assignment/utils/common/custom_button.dart';

class SelfieView extends ConsumerWidget {
  const SelfieView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final state = ref.watch(appStateNotifierProvider);
    final providerFuncCall = ref.read(appStateNotifierProvider.notifier);

    //lister to the count for photos taken and navigate
    ref.listen(
      appStateNotifierProvider,
      (previous, next) {
        if (next.capturedSelfies.length == 6 && next.retakeIndex == -1) {
          Navigator.pushNamed(context, AppRoutesNames.previewSelfiesView);
        }
      },
    );
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Take 6 selfies",
              style: CustomTextStyles.black24W400,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                height: height / 2,
                width: width / 1.25,
                decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(18),
                    image: state.capturedSelfies.isEmpty
                        ? null
                        : DecorationImage(
                            image: FileImage(File(state.retakeIndex == -1
                                ? state.capturedSelfies.last
                                : state.capturedSelfies[state.retakeIndex])),
                            fit: BoxFit.fill)),
                child: Stack(
                  fit: StackFit.loose,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            height: 100,
                            width: 75,
                            decoration: BoxDecoration(
                                color: AppColors.backgroundColor, borderRadius: BorderRadius.circular(12)),
                            child: Center(
                              child: Text(
                                state.capturedSelfies.length.toString(),
                                style: CustomTextStyles.black24W400.copyWith(fontSize: 60),
                              ),
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),
            CustomButton(
              icon: FontAwesomeIcons.camera,
              onTap: () {
                providerFuncCall.takeSelfies(context: context, retakeIndex: state.retakeIndex);
              },
              label: "Take Picture",
            )
          ],
        ),
      ),
    );
  }
}
