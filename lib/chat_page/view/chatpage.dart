import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:testapp/apis/apis.dart';
import 'package:testapp/chat_page/controller/chat_page_controller.dart';
import 'package:testapp/chat_page/view/chat_user_card.dart';
import 'package:testapp/model/chatmodel.dart';
import 'package:testapp/profile/views/profile_page_view.dart';
import 'package:testapp/setting.dart';
import 'package:testapp/to_do_task.dart';

class ChatPage extends StatefulWidget {
  ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();

    SystemChannels.lifecycle.setMessageHandler(
      (message) {
        log("message $message");
        if (message!.contains('resume')) APIs.updateActiveStatus(true);
        if (message.contains('pause')) APIs.updateActiveStatus(false);
        return Future.value(message);
      },
    );
  }

  final controller = Get.put(ChatPageController());
  List<ChatUser> list = [];

  // for Storing search items
  final List<ChatUser> searchList = [];

//  for checking search status
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (isSearching) {
          setState(() {
            isSearching = !isSearching;
          });
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.9),
        appBar: AppBar(
          elevation: 1,
          toolbarHeight: 60.h,
          backgroundColor: Colors.black,

          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.home,
              size: 30.sp,
              color: Colors.white,
            ),
          ),
          leadingWidth: 35.w,
          actions: [
            IconButton(
              splashRadius: 10.sp,
              onPressed: () {
                setState(
                  () {
                    isSearching = !isSearching;
                  },
                );
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => const TestPage()));
              },
              icon: Icon(
                isSearching == false
                    ? Icons.search
                    : CupertinoIcons.clear_circled_solid,
                color: Colors.white,
              ),
            ),
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
            PopupMenuButton(
                onSelected: (value) {
                  // Get.to(const Settings());
                },
                color: Colors.grey.shade800.withOpacity(
                  0.93,
                ),
                popUpAnimationStyle: AnimationStyle(
                  curve: Curves.decelerate,
                  duration: Duration(
                    seconds: 1,
                  ),
                ),
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
                        Get.to(ProofilePageView(user: APIs.me));
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
                        Get.to(ToDoTask());
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
                        Get.to(const TablePage());
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
                        Get.to(const Graphpage());
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
                        Get.to(const Settings());
                      },
                    ),
                    PopupMenuItem(
                      child: const Text(
                        "Log Out",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onTap: () async {
                        await APIs.auth.signOut();
                        await GoogleSignIn().signOut();
                      },
                    )
                  ];
                })
          ],

          title: isSearching == false
              ? RichText(
                  text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Cheat",
                      style: TextStyle(
                          shadows: [
                            Shadow(
                                color: Colors.green,
                                blurRadius: 1,
                                offset: Offset(1, 1))
                          ],
                          color: Colors.red,
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: "Chat",
                      style: TextStyle(
                          shadows: [
                            Shadow(
                                color: Colors.red,
                                blurRadius: 1,
                                offset: Offset(1, 1))
                          ],
                          color: Colors.green,
                          fontSize: 27.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ))
              : TextField(
                  autofocus: true,
                  onTapOutside: (event) =>
                      FocusManager.instance.primaryFocus!.unfocus(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Name, Email...",
                    hintStyle: TextStyle(
                      color: Colors.white54,
                    ),
                  ),
                  onChanged: (value) {
                    searchList.clear();
                    for (var i in list) {
                      if (i.name.toLowerCase().contains(value.toLowerCase()) ||
                          i.email.toLowerCase().contains(value.toLowerCase())) {
                        searchList.add(i);
                      }
                      setState(() {
                        searchList;
                      });
                    }
                  },
                ),
          automaticallyImplyLeading: false,
          // centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            top: 10,
          ),
          child: StreamBuilder(
            stream: APIs.getAllUserID(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                // if data is loading
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return Center(child: CircularProgressIndicator());

                case ConnectionState.active:
                case ConnectionState.done:
                  return StreamBuilder(
                      stream: APIs.getAllUser(
                          snapshot.data?.docs.map((e) => e.id).toList() ?? []),
                      builder: (context, snapshot) {
                        // log("hasdata: ${snapshot.hasData}");
                        final data = snapshot.data?.docs;

                        list = data
                                ?.map((e) => ChatUser.fromJson(e.data()))
                                .toList() ??
                            [];
                        if (list.isNotEmpty) {
                          return ListView.builder(
                            // physics: BouncingScrollPhysics(),

                            itemCount: isSearching == true
                                ? searchList.length
                                : list.length,
                            // controller.jsonList == null
                            //     ? 0
                            //     : controller.jsonList.length,
                            itemBuilder: (context, index) {
                              return ChatUserCard(
                                user: isSearching == true
                                    ? searchList[index]
                                    : list[index],
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: Text(
                              "No connections found !!",
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 30,
                              ),
                            ),
                          );
                        }

                        // log("Data: ${i.data()}");
                      });
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          // backgroundColor: Colors.green,
          onPressed: () {
            showUpdatedMSGDialogue();
          },
          child: Icon(
            Icons.add_comment_rounded,
          ),
        ),
      ),
    );
  }

  void showUpdatedMSGDialogue() {
    String email = "";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shadowColor: Colors.white,
        elevation: 5,
        backgroundColor: Colors.black.withOpacity(0.7),
        title: Row(
          children: [
            Icon(
              Icons.person_add,
              // size: 20.sp,
              color: Colors.grey,
            ),
            5.horizontalSpace,
            Text(
              "Add New",
              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        content: TextFormField(
          onChanged: (value) => email = value,
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            enabled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(
                20.r,
              ),
            ),
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
            hintText: "Email",
            prefixIcon: Icon(
              Icons.email,
              color: Colors.grey,
            ),
          ),
        ),
        actions: [
          MaterialButton(
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            color: Colors.red,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
          MaterialButton(
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              color: Colors.blue,
              onPressed: () async {
                // APIs.updateMessage(widget.message, updatedMsg);
                if (email.isNotEmpty) {
                  log("Email: $email");
                  if (email.trim().isNotEmpty) {
                    log("Email of the User: $email");

                    await APIs.addChatUser(email).then(
                      (value) {
                        log("Get this Email: $email");
                        if (!value) {
                          // Dialogs.showSnackbar(
                          //     context, 'User does not Exists!');
                        }
                      },
                    );

                    Navigator.pop(context);
                  }
                }
              },
              child: Text(
                "Add+",
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
        ],
      ),
    );
  }
}

class TablePage extends StatelessWidget {
  const TablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65.h,
        title: const Text("Table Widget"),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
            )),
      ),
      body: Table(
        children: const [
          TableRow(
            decoration: BoxDecoration(
              color: Colors.amber,
            ),
            children: [
              // TableCell(child: Text("data")),
              // TableCell(child: Text("data")),
              // TableCell(child: Text("data")),
              // TableCell(child: Text("data")),
              Text(
                " Name",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                " Data",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                " phone",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          TableRow(
            children: [
              Text(" Name"),
              Text(" Data"),
              Text(" phone"),
            ],
          ),
          TableRow(
            children: [
              Text(" Name"),
              Text(" Data"),
              Text(" phone"),
            ],
          )
        ],
        border: TableBorder.all(
          width: 1,
        ),
        textBaseline: TextBaseline.ideographic,
      ),
    );
  }
}

class Graphpage extends StatelessWidget {
  const Graphpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65.h,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
            )),
      ),
      body: Container(
        color: Colors.amber,
        child: GridPaper(
          // interval: 3,
          color: Colors.green,
          divisions: 4,
          subdivisions: 4,
          child: Container(
            // height: 300,
            // width: 300,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
