import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/calls_page/view/call_page.dart';
import 'package:testapp/chat_page/view/chatpage.dart';
import 'package:testapp/news_page/view/newspage.dart';
import 'package:testapp/status_page/view/status_page.dart';

import '../controller/main_controller.dart';

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
        () => BottomNavigationBar(
          backgroundColor: Colors.black,
          elevation: 5,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.grey,
          currentIndex: controller.nowPage.value,
          onTap: (value) {
            controller.pageViewController.jumpToPage(value);
          },
          items: [
            BottomNavigationBarItem(
              // backgroundColor:
              //     controller.nowPage.value == 0 ? Colors.red : Colors.amber,

              icon: Icon(
                Icons.chat,
                color:
                    controller.nowPage.value == 0 ? Colors.blue : Colors.grey,
              ),
              label: "Chat",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.update,
                color:
                    controller.nowPage.value == 1 ? Colors.blue : Colors.grey,
              ),
              label: "Status",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.newspaper,
                color:
                    controller.nowPage.value == 2 ? Colors.blue : Colors.grey,
              ),
              label: "News",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.call,
                color:
                    controller.nowPage.value == 3 ? Colors.blue : Colors.grey,
              ),
              label: "Calls",
            ),
          ],
        ),
      ),
    );
  }
}
