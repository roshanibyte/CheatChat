import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:testapp/apis/apis.dart';
import 'package:testapp/main_page/view/main_page.dart';

class LogInController extends GetxController {
  RxBool isAnimated = true.obs;
  @override
  void onInit() {
    super.onInit();
    animatedImage();
  }

  void animatedImage() {
    Future.delayed(
      Duration(seconds: 1),
      () {
        isAnimated.value = !isAnimated.value;
      },
    );
  }

  handleGoogleBtnClick() {
    // log("handleGoogleBtnClick: ${User} ");

    signInWithGoogle().then((user) async {
      log("login with user:  ${user}");
      if (user != null) {
        log("\nuser: ${user.user}");
        log("\nuser info: ${user.additionalUserInfo}");
        if ((await APIs.userExist())) {
          Get.off(MainPage());
        } else {
          await APIs.createUser().then((value) {
            Get.to(MainPage());
          });
        }

        Get.to(() => MainPage());
      }
    });
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      await InternetAddress.lookup("google.com");
// Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // Once signed in, return the UserCredential
      final res = await APIs.auth.signInWithCredential(credential);
      log("sign in with g ${res}");
      return res;
    } catch (e) {
      log("signInWithGoogle:  $e");
    }
    Get.snackbar(
      "Check Internet Connection",
      "Or may be internet is slow",
      backgroundColor: Colors.white60,
    );
    return null;
  }
}
