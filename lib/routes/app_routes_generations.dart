import 'package:flutter/cupertino.dart';
import 'package:unstudio_assignment/routes/app_routes_names.dart';
import 'package:unstudio_assignment/views/home_view.dart';
import 'package:unstudio_assignment/views/preview_selfies_view.dart';
import 'package:unstudio_assignment/views/selfie_view.dart';
import 'package:unstudio_assignment/views/signin_view.dart';

mixin AppRoutesGenerations {
  final Map<String, Widget Function(BuildContext, dynamic)> _routes = {
    AppRoutesNames.takeSelfieView: (context, args) => SelfieView(),
    AppRoutesNames.signinView: (context, args) => SigninView(),
    AppRoutesNames.previewSelfiesView: (context, args) => PreviewSelfiesView(),
    AppRoutesNames.homeView: (context, args) => HomeView(),
  };

  Map<String, Widget Function(BuildContext, dynamic)> get routes {
    return _routes;
  }
}
