import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (controller) {
        return const Scaffold(
          body: Center(
            child: Text(
              "Splash Screen",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
              ),
            ),
          ),
        );
      },
    );
  }
}
