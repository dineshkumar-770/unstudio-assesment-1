

class AppRoutesNames {
  static String initialRoute = getInitialRoute();
  static const String takeSelfieView = "/takeSelfieView";
  static const String signinView = "/signinView";
  static const String previewSelfiesView = "/previewSelfiesView";
  static const String homeView = "/homeView";

  static String getInitialRoute() {
    ///Uncomment this code to pake screen presist when sign in with google
    // final storedCredentials = Prefs.getString(ConstantStrings.userGoogleProfileKey);
    // if (storedCredentials.isNotEmpty) {
    //   return takeSelfieView;
    // }
    return signinView;
  }
}
