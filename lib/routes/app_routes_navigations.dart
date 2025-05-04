import 'package:flutter/cupertino.dart';
import 'package:unstudio_assignment/routes/app_routes_generations.dart';
import 'package:unstudio_assignment/routes/app_routes_names.dart';

class AppRoutesNavigation with AppRoutesGenerations {
  Route<dynamic>? generate(settings) {
    switch (settings.name) {
      case AppRoutesNames.takeSelfieView:
        return CupertinoPageRoute(builder: (context) => routes[AppRoutesNames.takeSelfieView]!(context, {}));
      case AppRoutesNames.signinView:
        return CupertinoPageRoute(builder: (context) => routes[AppRoutesNames.signinView]!(context, {}));
      case AppRoutesNames.previewSelfiesView:
        return CupertinoPageRoute(builder: (context) => routes[AppRoutesNames.previewSelfiesView]!(context, {}));
      case AppRoutesNames.homeView:
        return CupertinoPageRoute(builder: (context) => routes[AppRoutesNames.homeView]!(context, {}));
        
      default:
        return null;
    }
  }
}
