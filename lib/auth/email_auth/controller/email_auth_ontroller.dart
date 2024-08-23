import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/main_page/view/main_page.dart';

class EmailAuthController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  // TextEditingController cController = TextEditingController();

  bool obscureTxt = true;
  // bool obscuretxt = true;

  Future<void> loginUser() async {
    log("message");
    String email = emailController.text.trim();
    String Password = passController.text.trim();

    if (email.isEmpty || Password.isEmpty) {
      log("Invalid Email and Password");
      Get.snackbar("Fill all the details", "Fill Details",
          duration: const Duration(seconds: 3),
          // colorText: Colors.red,
          dismissDirection: DismissDirection.horizontal,
          backgroundColor: Colors.white60,
          barBlur: 3);
    } else {
      log("LoginUser: $email");
      log("LoginUser: $Password");
      // await FirebaseAuth.instance.signOut();
      try {
        // await InternetAddress.lookup("google.com");

        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: Password);
        // log(userCredential.user.toString());
        if (userCredential.user != null) {
          Get.to(const MainPage());
          Get.snackbar("Logged In Successfully", "Successful",
              duration: const Duration(seconds: 3),
              // colorText: Colors.black,
              dismissDirection: DismissDirection.horizontal,
              // colorText: Colors.white54,
              backgroundColor: Colors.white60,
              barBlur: 3);
        }
      } catch (e) {
        Get.snackbar("Internet issue", "Successful",
            duration: const Duration(seconds: 3),
            // colorText: Colors.black,
            dismissDirection: DismissDirection.horizontal,
            // colorText: Colors.greenAccent,
            backgroundColor: Colors.white60,
            barBlur: 3);
        log("On Firebase Login ${e}");
      }
      return null;
    }
  }
}
