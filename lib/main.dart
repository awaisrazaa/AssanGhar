import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onboard_animation/components/Dashboard.dart';
import 'package:onboard_animation/components/details_screen.dart';
import 'package:onboard_animation/firebase_options.dart';
import 'package:onboard_animation/onboarding_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(375, 812),
    builder: (BuildContext context,child) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Assan Ghar',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const OnboardingScreen(),
      );
    }
    );
  }
}
