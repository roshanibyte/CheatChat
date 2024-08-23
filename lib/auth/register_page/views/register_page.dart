import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:testapp/auth/register_page/controller/register_page_controller.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final controller = Get.put(RegisterPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade600,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: InkWell(
        //       onTap: () {
        //         // Get.to(const HelpPage());
        //       },
        //       child: const Column(
        //         children: [
        //           Icon(
        //             Icons.help,
        //             color: Colors.white,
        //           ),
        //           Text(
        //             " Help",
        //             style: TextStyle(
        //               fontWeight: FontWeight.bold,
        //               color: Colors.white,
        //               fontSize: 12,
        //             ),
        //           )
        //         ],
        //       ),
        //     ),
        //   )
        // ],
        title: const Text(
          "RegisterPage",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 11),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                style: TextStyle(
                  color: Colors.white,
                ),
                cursorColor: Colors.white,
                controller: controller.nameControlller,
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
                    prefixIcon: Icon(
                      Icons.abc,
                      color: Colors.white,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    hintText: "Enter Your Name"),
              ),
              const SizedBox(
                height: 11,
              ),
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
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    hintText: "Enter Your Email"),
              ),
              const SizedBox(
                height: 11,
              ),

              TextField(
                style: TextStyle(
                  color: Colors.white,
                ),
                cursorColor: Colors.white,

                controller: controller.selectedDateController,
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now());
                  if (selectedDate != null) {
                    String formatedDate =
                        DateFormat("yyyy-MM-dd").format(selectedDate);

                    controller.selectedDateController.text =
                        formatedDate.toString();
                  }
                },
                // keyboardType: TextInputType.datetime,
                // obscureText: true,
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
                    prefixIcon: Icon(
                      Icons.date_range,
                      color: Colors.white,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    hintText: "Date of Birth"),
              ),
              const SizedBox(
                height: 11,
              ),
              Obx(
                () => TextField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  cursorColor: Colors.white,
                  controller: controller.passwordController,
                  obscureText: controller.obsecureTxt.value,
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
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.obsecureTxt.toggle();
                      },
                      icon: Icon(
                        controller.obsecureTxt.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: controller.obsecureTxt.value
                            ? Colors.white38
                            : Colors.white,
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.password,
                      color: Colors.white,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    hintText: "Set Your Password",
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // TextWidget(
              //   text: "Save",
              //   padding: const EdgeInsets.only(right: 50, left: 50, top: 8),
              //   onTap: () => createAccount(),
              // )
              SizedBox(
                height: 40,
                width: 100,
                child: ElevatedButton(
                  // style: const ButtonStyle(
                  //   backgroundColor: MaterialStatePropertyAll(Colors.blue),
                  //   foregroundColor: MaterialStatePropertyAll(Colors.white),
                  // ),
                  onPressed: () {
                    // Get.off(const MyApp());
                    // Get.pop(const MyProfile());
                    controller.createAccount();
                  },
                  child: const Text("Save"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
