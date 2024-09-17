import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testapp/QR_page/view/qr_scanner_page.dart';
import 'package:testapp/chat_page/view/chatpage.dart';
import 'package:testapp/chat_setting.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool colorChange = true;

  Color greenBackground = Colors.green;
  Color defaultBackground = Colors.grey.shade800;
  String imagePath = "";
  final picker = ImagePicker();
  File? image;
  List item = [
    "Chat Setting",
    "Account",
    "Privacy",
    "Notification",
    "Storage",
    "Backup",
    "Terms And Condition"
  ];

  List icons = [
    const Icon(
      Icons.settings,
      color: Colors.white,
    ),
    const Icon(
      Icons.account_balance,
      color: Colors.white,
    ),
    const Icon(
      Icons.privacy_tip,
      color: Colors.white,
    ),
    const Icon(
      Icons.notifications,
      color: Colors.white,
    ),
    const Icon(
      Icons.storage,
      color: Colors.white,
    ),
    const Icon(
      Icons.backup,
      color: Colors.white,
    ),
    const Icon(
      Icons.security,
      color: Colors.white,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          colorChange == true ? defaultBackground : greenBackground,
      appBar: AppBar(
        toolbarHeight: 65.h,

        elevation: 1,
        backgroundColor: Colors.grey.withOpacity(0.6),
        actions: [
          GestureDetector(
              onTap: () {
                setState(() {
                  colorChange = !colorChange;
                });
              },
              // onDoubleTap: () {
              //   setState(() {
              //     backgroundColor = Colors.yellow;
              //   });
              // },
              child: const Icon(Icons.color_lens)),
          const SizedBox(
            width: 10,
          )
        ],

        title: const Text(
          "Setting",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        // centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          // left: 05,
          right: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
                leading: Container(
                  height: 70,
                  width: 70,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: InkWell(
                      onTap: () async {
                        final pickedFile = await picker.pickImage(
                          source: ImageSource.gallery,
                        );
                        if (pickedFile != null) {
                          setState(() {
                            imagePath = pickedFile.path;
                          });
                        }
                      },
                      child: imagePath == ""
                          ? const Icon(
                              Icons.person,
                              color: Colors.white,
                            )
                          : Image.file(
                              File(imagePath),
                              fit: BoxFit.cover,
                            )),
                ),
                title: const Text(
                  "Your Name ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                subtitle: const Text(
                  "Your Bio ",
                  style: TextStyle(
                    fontSize: 12,
                    // fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    Get.to(const QrViewPage());
                  },
                  icon: Icon(
                    Icons.qr_code_scanner,
                    size: 30,
                    color: colorChange == true ? Colors.green : Colors.white,
                  ),
                )

                // Icon(
                //   Icons.arrow_drop_down,
                //   size: 30,
                //   color: Colors.green,
                // ),
                ),
            const Divider(
              thickness: 0.5,
              color: Colors.white,
            ),
            SizedBox(
              height: Get.height * 0.7,
              child: ListView.builder(
                itemCount: item.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    splashColor: Colors.transparent,
                    onTap: () {
                      if (index == 0) {
                        Get.to(const DismissedItem());
                      } else if (index == 1) {
                        Get.to(const CricketPitch());
                      } else if (index == 2) {
                        Get.to(ChatPage());
                      } else {
                        log("Vacant Page");
                      }
                    },
                    title: Text(
                      item[index],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    leading: icons[index],
                    subtitle: const Text(
                      "Change this setting",
                      style: TextStyle(
                        fontSize: 13,
                        // fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    // color: Colors.white,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
