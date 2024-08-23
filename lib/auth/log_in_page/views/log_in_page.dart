import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:testapp/auth/email_auth/views/emailauth.dart';
import 'package:testapp/auth/log_in_page/controller/log_in_controller.dart';
import 'package:testapp/auth/register_page/views/register_page.dart';

class LogInPage extends StatelessWidget {
  LogInPage({super.key});
  final controller = Get.put(LogInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Login and Register",
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.cente,
        children: [
          Obx(
            () => AnimatedPositioned(
              duration: Duration(seconds: 2),
              top: 100.h,
              right: controller.isAnimated.value == false
                  ? Get.width * 0.22
                  : -(Get.width),
              child: Image.asset(
                "assets/chatAPP.png",
                height: 200,
                width: 200,
              ),
            ),
          ),
          Positioned(
            top: 445.h,
            left: 30.w,
            height: 40.h,
            width: 300.w,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                shadowColor: Colors.grey,
                elevation: 3,
                shape: StadiumBorder(),
              ),
              onPressed: () {
                controller.handleGoogleBtnClick();
                Future.delayed(
                  Duration(milliseconds: 300),
                  () {
                    Get.snackbar(
                      "Login With Google",
                      "Welcome to the ChatAPP",
                      backgroundColor: Colors.white60,
                    );
                  },
                );
              },
              icon: SvgPicture.asset(
                "assets/google-icon.svg",
                height: 20.h,
                width: 20.w,
              ),
              label: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Login With",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: " Goolge",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),

              // Text(
              //   "Login With Goolge",
              //   style: TextStyle(
              //     fontSize: 15,
              //   ),
              // ),
            ),
          ),
          Positioned(
            top: 495.h,
            left: 30.w,
            height: 40.h,
            width: 300.w,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                shadowColor: Colors.grey,
                elevation: 3,
                shape: StadiumBorder(),
              ),
              onPressed: () {
                Get.to(EmailAuthPage());
              },
              icon: Icon(
                Icons.email,
                color: Colors.black,
                size: 30,
              ),
              label: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Login With",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: " Email",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // Text(
              //   "Login With Email",
              //   style: TextStyle(
              //     fontSize: 15,
              //   ),
              // ),
            ),
          ),
          Positioned(
            top: 535.h,
            left: 205.w,
            height: 40.h,
            width: 300.w,
            child: InkWell(
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent,
              onTap: () {
                Get.to(RegisterPage());
              },
              child: Text(
                "Create a new account?",
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
