import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/auth/email_auth/views/emailauth.dart';

class RegisterPageController extends GetxController {
  TextEditingController nameControlller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController selectedDateController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool obsecureTxt = true.obs;


  Future<void> createAccount() async {
    String email = emailController.text.trim();
    String name = nameControlller.text.trim();

    // String phone = phonecontroller.text.trim();
    String DOB = selectedDateController.text.trim();

    String password = passwordController.text.trim();

    if (name == "" ||
        email == "" ||
        // phone == "" ||
        DOB == "" ||
        password == "") {
      log("Fill all the Details");
    } else {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      Get.to(() => const EmailAuthPage());
      log(" User Created");
    }
  }
}
