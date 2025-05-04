// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:unstudio_assignment/models/all_garments_data_model.dart';

class AppStates extends Equatable {
  final bool googleSignInLoading;
  final List<String> capturedSelfies;
  final int retakeIndex;
  final bool fetchAllGarmentsLoading;
  final String allGaremnetsErrorMsg;
  final AllGarmentsDataModel allGarmentsDataModel;
  final Garment selectedTOP;
  final Garment selectedBOTTOM;
  final bool initializeCameraLoading;
  final String initializeCameraError;

  const AppStates({
    required this.googleSignInLoading,
    required this.capturedSelfies,
    required this.retakeIndex,
    required this.fetchAllGarmentsLoading,
    required this.allGaremnetsErrorMsg,
    required this.allGarmentsDataModel,
    required this.selectedTOP,
    required this.selectedBOTTOM,
    required this.initializeCameraLoading,
    required this.initializeCameraError,
  });

  factory AppStates.initialize() {
    return AppStates(
        googleSignInLoading: false,
        capturedSelfies: const [],
        allGaremnetsErrorMsg: "",
        retakeIndex: -1,
        initializeCameraError: "",
        initializeCameraLoading: false,
        selectedBOTTOM: Garment(),
        selectedTOP: Garment(),
        allGarmentsDataModel: AllGarmentsDataModel(),
        fetchAllGarmentsLoading: false);
  }
  @override
  List<Object> get props {
    return [
      googleSignInLoading,
      capturedSelfies,
      retakeIndex,
      fetchAllGarmentsLoading,
      allGaremnetsErrorMsg,
      allGarmentsDataModel,
      selectedTOP,
      selectedBOTTOM,
      initializeCameraLoading,
      initializeCameraError,
    ];
  }

  AppStates copyWith({
    bool? googleSignInLoading,
    List<String>? capturedSelfies,
    int? retakeIndex,
    bool? fetchAllGarmentsLoading,
    String? allGaremnetsErrorMsg,
    AllGarmentsDataModel? allGarmentsDataModel,
    Garment? selectedTOP,
    Garment? selectedBOTTOM,
    bool? initializeCameraLoading,
    String? initializeCameraError,
  }) {
    return AppStates(
      googleSignInLoading: googleSignInLoading ?? this.googleSignInLoading,
      capturedSelfies: capturedSelfies ?? this.capturedSelfies,
      retakeIndex: retakeIndex ?? this.retakeIndex,
      fetchAllGarmentsLoading: fetchAllGarmentsLoading ?? this.fetchAllGarmentsLoading,
      allGaremnetsErrorMsg: allGaremnetsErrorMsg ?? this.allGaremnetsErrorMsg,
      allGarmentsDataModel: allGarmentsDataModel ?? this.allGarmentsDataModel,
      selectedTOP: selectedTOP ?? this.selectedTOP,
      selectedBOTTOM: selectedBOTTOM ?? this.selectedBOTTOM,
      initializeCameraLoading: initializeCameraLoading ?? this.initializeCameraLoading,
      initializeCameraError: initializeCameraError ?? this.initializeCameraError,
    );
  }
}
