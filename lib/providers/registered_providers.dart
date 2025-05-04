import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unstudio_assignment/controller/app_controller.dart';
import 'package:unstudio_assignment/controller/app_states.dart';

final appStateNotifierProvider = StateNotifierProvider<AppStateNotifier, AppStates>((ref) {
  return AppStateNotifier();
});
