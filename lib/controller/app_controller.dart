import 'dart:convert';
import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unstudio_assignment/controller/app_states.dart';
import 'package:unstudio_assignment/core/di.dart';
import 'package:unstudio_assignment/core/local_storage.dart';
import 'package:unstudio_assignment/core/permission_handler.dart';
import 'package:unstudio_assignment/models/all_garments_data_model.dart';
import 'package:unstudio_assignment/repository/api_calls.dart';
import 'package:unstudio_assignment/utils/constants/constant_strings.dart';

class AppStateNotifier extends StateNotifier<AppStates> {
  AppStateNotifier() : super(AppStates.initialize());

  final PermissionService _permissionService = PermissionService();
  final _repositary = locatorDI<ApiCalls>();
  CameraController? cameraController;

  Future<bool> googleSignIN() async {
    try {
      state = state.copyWith(googleSignInLoading: true);
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final OAuthCredential authCredentials = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final userCredentials = await FirebaseAuth.instance.signInWithCredential(
          authCredentials,
        );

        log(userCredentials.toString());
        if (userCredentials.user?.uid != null) {
          Map<String, dynamic> authUserInfo = {};
          authUserInfo[ConstantStrings.googleAuthUserID] = userCredentials.user?.uid ?? "";
          authUserInfo[ConstantStrings.googleAuthProfile] = userCredentials.user?.photoURL ?? "";
          authUserInfo[ConstantStrings.googleAuthName] = userCredentials.user?.displayName ?? "";
          authUserInfo[ConstantStrings.googleAuthEmail] = userCredentials.user?.email ?? "";
          Prefs.setString(
            ConstantStrings.userGoogleProfileKey,
            jsonEncode(authUserInfo),
          );
          state = state.copyWith(googleSignInLoading: false);
          return true;
        } else {
          state = state.copyWith(googleSignInLoading: false);
          return false;
        }
      } else {
        state = state.copyWith(googleSignInLoading: false);
        return false;
      }
    } catch (e) {
      log(e.toString());
      state = state.copyWith(googleSignInLoading: false);
      return false;
    }
  }

  Future<bool> googleLogout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Prefs.clear();
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<void> initializeSelfieCamera() async {
    state = state.copyWith(initializeCameraLoading: true, initializeCameraError: "");
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );
    cameraController = CameraController(frontCamera, ResolutionPreset.high);
    cameraController?.initialize().then(
      (value) {
        if (!mounted) {
          state = state.copyWith(initializeCameraLoading: false, initializeCameraError: "Error in loading camera");
          return;
        }
        state = state.copyWith(initializeCameraLoading: false, initializeCameraError: "");
      },
    ).catchError((e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            state = state.copyWith(initializeCameraLoading: true, initializeCameraError: e.description.toString());
            break;
          default:
            state = state.copyWith(initializeCameraLoading: true, initializeCameraError: e.description.toString());
            break;
        }
      }
    });
  }

  void cleanMedia() async {
    // Using this method to dispose of the media held in AppState for better consistency, memory optmization and app state hygiene.
    // The reason is that we don't want AppState to retain media data until the app restarts.
    // Ideally, after uploading media images to the server, they should be removed from state
    // when navigating to the next screen to avoid holding unnecessary memory.
    state = state.copyWith(
      capturedSelfies: [],
    );
  }

  void updatedRetakeIndex(int index) {
    state = state.copyWith(retakeIndex: index);
  }

  Future<void> takeSelfies({required BuildContext context, required int retakeIndex}) async {
    state = state.copyWith(retakeIndex: retakeIndex);
    List<String> preCapturedSelfies = List.from(state.capturedSelfies);
    final isGranted = await _permissionService.requestCameraPermission(context);
    if (isGranted) {
      XFile? capturedFiles = await cameraController?.takePicture();

      if (capturedFiles != null) {
        if (retakeIndex != (-1)) {
          preCapturedSelfies.removeAt(retakeIndex);
          preCapturedSelfies.insert(retakeIndex, capturedFiles.path);
        } else {
          preCapturedSelfies.add(capturedFiles.path);
        }
      }
      state = state.copyWith(capturedSelfies: preCapturedSelfies, retakeIndex: -1);
    }
    await Future.delayed(const Duration(milliseconds: 400));
  }

  Future<void> fetchAllGarments() async {
    cleanMedia();
    state = state.copyWith(
      fetchAllGarmentsLoading: true,
      allGaremnetsErrorMsg: "",
    );
    final response = await _repositary.getAllGarmentsData();

    response.fold(
      (resp) {
        AllGarmentsDataModel allGarmentsDataModel = AllGarmentsDataModel();
        try {
          allGarmentsDataModel = AllGarmentsDataModel.fromJson(resp);
          state = state.copyWith(allGaremnetsErrorMsg: "", allGarmentsDataModel: allGarmentsDataModel, fetchAllGarmentsLoading: false);
        } catch (e) {
          log(e.toString());
          state = state.copyWith(allGaremnetsErrorMsg: e.toString(), fetchAllGarmentsLoading: false);
        }
      },
      (errorMsg) {
        state = state.copyWith(allGaremnetsErrorMsg: errorMsg, fetchAllGarmentsLoading: false);
      },
    );
  }

  void selectBottomGarment(Garment value) {
    state = state.copyWith(selectedBOTTOM: value);
  }

  void selectTopGarment(Garment value) {
    state = state.copyWith(selectedTOP: value);
  }
}
