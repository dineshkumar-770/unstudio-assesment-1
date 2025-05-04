import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unstudio_assignment/providers/registered_providers.dart';
import 'package:unstudio_assignment/routes/app_routes_names.dart';
import 'package:unstudio_assignment/themes/app_colors.dart';
import 'package:unstudio_assignment/themes/text_styles.dart';

class SigninView extends StatelessWidget {
  const SigninView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Consumer(builder: (context, ref, _) {
        final signInState = ref.watch(appStateNotifierProvider);
        return Center(
          child: ElevatedButton.icon(
              style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(AppColors.black)),
              onPressed: () async {
                final isSigninSuccess = await ref.read(appStateNotifierProvider.notifier).googleSignIN();
                if (isSigninSuccess && context.mounted) {
                  Navigator.pushReplacementNamed(context, AppRoutesNames.takeSelfieView);
                }
                log(isSigninSuccess.toString());
              },
              icon: Icon(
                FontAwesomeIcons.google,
                color: AppColors.white,
              ),
              label: Text(
                signInState.googleSignInLoading ? "Signing in..." : "Sign in with Google",
                style: CustomTextStyles.white18W400,
              )),
        );
      }),
    );
  }
}
