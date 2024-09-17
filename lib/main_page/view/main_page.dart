import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:testapp/calls_page/view/call_page.dart';
import 'package:testapp/chat_page/view/chatpage.dart';
import 'package:testapp/main_page/controller/main_controller.dart';
import 'package:testapp/news_page/view/newspage.dart';
import 'package:testapp/status_page/view/status_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

final controller = Get.put(HomeController());

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageViewController,
        onPageChanged: (value) {
          controller.nowPage.value = value;
        },
        children: [
          ChatPage(),
          StausPage(),
          NewsPage(),
          CallPageView(),
        ],
      ),
      bottomNavigationBar: Obx(
        () => CurvedNavigationBar(
          onTap: (value) {
            controller.pageViewController.jumpToPage(value);
          },
          index: controller.nowPage.value,
          backgroundColor: Colors.black.withOpacity(0.9),
          height: 50.h,
          color: Colors.grey.shade600,
          items: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.chat,
                    color: Colors.white,
                  ),
                  Text(
                    "Chat",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    color: Colors.white,
                    Icons.update,
                  ),
                  Text(
                    "Update",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    color: Colors.white,
                    Icons.newspaper,
                  ),
                  Text(
                    "News",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    color: Colors.white,
                    Icons.call,
                  ),
                  Text(
                    "Calls",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
