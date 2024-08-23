import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:testapp/auth/email_auth/controller/email_auth_ontroller.dart';
// import 'package:news_app/login_page/authantications/create_account.dart';
// import 'package:news_app/mainpage/mainpage.dart';
// import 'package:news_app/routes/approutes.dart';
// import 'package:news_app/view/news_page/newspage.dart';
import 'package:testapp/constants/commom_widgets.dart';

class EmailAuthPage extends StatefulWidget {
  const EmailAuthPage({super.key});

  @override
  State<EmailAuthPage> createState() => _EmailAuthState();
}

class _EmailAuthState extends State<EmailAuthPage> {
  final controller = Get.put(EmailAuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade600,
        title: textwidget(
          data: "Email Login",
          color: Colors.white,
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Column(
          children: [
            textwidget(
              data: "Login With Your Email and \nPassword:",
              color: Colors.white,
              fontSize: 20,
              decoration: TextDecoration.underline,
              decorationColor: Colors.white,
            ),
            10.verticalSpace,
            TextField(
                style: TextStyle(
                  color: Colors.white,
                ),
                cursorColor: Colors.white,
                controller: controller.emailController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white70,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white38,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  hintText: "Email",
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            TextField(
              style: TextStyle(
                color: Colors.white,
              ),
              cursorColor: Colors.white,
              controller: controller.passController,
              obscureText: controller.obscureTxt,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white70,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white38,
                  ),
                ),
                border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    21,
                  ),
                ),
                hintText: "Enter Password",
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      controller.obscureTxt = !controller.obscureTxt;
                    });
                  },
                  icon: Icon(
                    controller.obscureTxt
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color:
                        controller.obscureTxt ? Colors.white38 : Colors.white,
                  ),
                ),
                prefixIcon: const Icon(
                  Icons.password,
                  color: Colors.white,
                ),
              ),
            ),

            // const SizedBox(
            //   height: 20,
            // ),
            // TextField(
            //   controller: cController,
            //   obscureText: obscuretxt,
            //   decoration: InputDecoration(
            //     hintText: "Confirm Password",
            //     prefixIcon: const Icon(Icons.password),
            //     suffixIcon: IconButton(
            //       onPressed: () {
            //         setState(() {
            //           obscuretxt = !obscuretxt;
            //         });
            //       },
            //       icon: Icon(
            //           obscuretxt ? Icons.visibility_off : Icons.visibility),
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue),
                    foregroundColor: MaterialStatePropertyAll(Colors.white),
                  ),
                  onPressed: () {
                    controller.loginUser();
                    // createaccount();
                  },
                  child: const Text("Login")),
            ),
            Column(
              // crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    // Get.to(() => const CreateAccount());
                  },
                  child: textwidget(
                      data: "SignUp with New account !!",
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.blue),
                ),
                textwidget(
                    data: "Forgot Password?",
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
