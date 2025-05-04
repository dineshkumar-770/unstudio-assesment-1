import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unstudio_assignment/core/di.dart';
import 'package:unstudio_assignment/core/local_storage.dart';
import 'package:unstudio_assignment/firebase_options.dart';
import 'package:unstudio_assignment/routes/app_routes_names.dart';
import 'package:unstudio_assignment/routes/app_routes_navigations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initializeLocationDI();
  await Prefs.init();
  runApp(ProviderScope(child: MyApp()));
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AppRoutesNavigation _appRoutesNavigation = AppRoutesNavigation();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unstudio Assignment',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: AppRoutesNames.initialRoute,
      onGenerateRoute: (settings) {
        return _appRoutesNavigation.generate(settings);
      },
    );
  }
}
