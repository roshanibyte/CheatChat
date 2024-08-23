import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:testapp/auth/log_in_page/views/log_in_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Get.to(
        LogInPage(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Stack(children: [
        Positioned(
          top: 100.h,
          left: 30.w,
          child: AnimatedContainer(
              curve: Curves.bounceIn,
              height: 300,
              width: 300,
              duration: const Duration(seconds: 5),
              // color: Colors.red,
              child: Image.asset(
                "assets/chatAPP.png",
                height: 300.h,
                width: 300.w,
              )),
        ),
        Positioned(
          bottom: 150.h,
          left: 60.w,
          child: Text(
            "MADE IN INDIA WITH ❤️",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              wordSpacing: 2,
              color: Colors.white,
            ),
          ),
        )
      ]),
    );
  }
}
