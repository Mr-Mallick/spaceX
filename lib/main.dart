import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacex/ui/homepage.dart';
import 'package:spacex/ui/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SpaceX Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
          primaryColor: Colors.black),
      home: const SplashScreen(),
    );
  }
}
