import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CallPageView extends StatelessWidget {
  CallPageView({super.key});

  final now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const SplashScreen(),
              //   ),
              // );
            },
            icon: const Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => const TestPage()));
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          PopupMenuButton(
              onSelected: (value) {
                // Get.to(const Settings());
              },
              color: Colors.black,
              icon: const Icon(
                Icons.more_vert_rounded,
                color: Colors.white,
              ),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: const Text(
                      "info",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      // Get.to(const CalanderPage());
                    },
                  ),
                  PopupMenuItem(
                    child: const Text(
                      "Chat",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      // Get.to(const ChoiceChipExample());
                    },
                  ),
                  PopupMenuItem(
                    child: const Text(
                      "Copy",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      // Get.to(const TablePage());
                    },
                  ),
                  PopupMenuItem(
                    child: const Text(
                      "Forward",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      // Get.to(const Graphpage());
                    },
                  ),
                  PopupMenuItem(
                    child: const Text(
                      "Setting",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      // Get.to(const Settings());
                    },
                  )
                ];
              })
        ],
        title: Text("Calls"),
        leading: Icon(
          Icons.arrow_back,
          // color: ,
        ),
      ),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: ListView.builder(
          // itemCount: 20,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black38,
                child: Icon(Icons.person),
              ),
              subtitle: Text(
                "13th may, 12.00",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              title: Text(
                "SuperHeros",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              trailing: SizedBox(
                width: 70,
                child: Row(
                  children: [
                    Icon(
                      Icons.video_call,
                      color: Colors.white,
                    ),
                    20.horizontalSpace,
                    Icon(
                      Icons.call,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
