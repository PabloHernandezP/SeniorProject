import 'package:equine_ai/controllers/filter_controller.dart';
import 'package:equine_ai/pages/dashboard/dashboard.dart';
import 'package:equine_ai/pages/login/login_screen.dart';
import 'package:equine_ai/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/login/firebase_options.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final filterController = Get.put(FilterController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //home: LoginScreen(),
      //routes: {'/login': (_) => LoginScreen(), '/dashboard': (_) => Dashboard()},
      initialRoute: "/login",
      //routes: appRoutes(),
      getPages: appRoutes(),

    );
  }
}
