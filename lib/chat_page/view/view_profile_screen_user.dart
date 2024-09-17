import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:testapp/chat_page/view/tic_toc_toe/tic_toc_toe.dart';
import 'package:testapp/helper/my_date_util.dart';
import 'package:testapp/model/chatmodel.dart';

class ViewProfileScreenUser extends StatefulWidget {
  final ChatUser user;

  const ViewProfileScreenUser({super.key, required this.user});

  @override
  State<ViewProfileScreenUser> createState() => _ViewProfileScreenUserState();
}

class _ViewProfileScreenUserState extends State<ViewProfileScreenUser> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.9),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: Colors.yellowAccent,
        ),
        width: 150.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Joined on : ",
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            Text(
              MyDateUtil.getLastMessageTime(
                context: context,
                time: widget.user.createdAt,
                showYear: true,
              ),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        leadingWidth: 30.w,
        toolbarHeight: 65.h,


        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back)),

        backgroundColor: Colors.black,
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
              Icons.video_call_rounded,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.call,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
             
            },
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ),

          // PopupMenuButton(
          //     onSelected: (value) {
          //       // Get.to(const Settings());
          //     },
          //     color: Colors.grey.shade800.withOpacity(
          //       0.93,
          //     ),
          //     popUpAnimationStyle: AnimationStyle(
          //       curve: Curves.decelerate,
          //       duration: Duration(
          //         seconds: 1,
          //       ),
          //     ),
          //     icon: const Icon(
          //       Icons.more_vert_rounded,
          //       color: Colors.white,
          //     ),
          //     itemBuilder: (context) {
          //       return [
          //         PopupMenuItem(
          //           child: const Text(
          //             "info",
          //             style: TextStyle(
          //               color: Colors.white,
          //             ),
          //           ),
          //           onTap: () {
          //             // Get.to(const CalanderPage());
          //           },
          //         ),
          //         PopupMenuItem(
          //           child: const Text(
          //             "Chat",
          //             style: TextStyle(
          //               color: Colors.white,
          //             ),
          //           ),
          //           onTap: () {
          //             // Get.to(const ChoiceChipExample());
          //           },
          //         ),
          //         PopupMenuItem(
          //           child: const Text(
          //             "Copy",
          //             style: TextStyle(
          //               color: Colors.white,
          //             ),
          //           ),
          //           onTap: () {
          //             // Get.to(const TablePage());
          //           },
          //         ),
          //         PopupMenuItem(
          //           child: const Text(
          //             "Forward",
          //             style: TextStyle(
          //               color: Colors.white,
          //             ),
          //           ),
          //           onTap: () {
          //             // Get.to(const Graphpage());
          //           },
          //         ),
          //         PopupMenuItem(
          //           child: const Text(
          //             "Setting",
          //             style: TextStyle(
          //               color: Colors.white,
          //             ),
          //           ),
          //           onTap: () {
          //             Get.to(const Settings());
          //           },
          //         ),

          //         // Logout button
          //         PopupMenuItem(
          //           child: const Text(
          //             "Log Out",
          //             style: TextStyle(
          //               color: Colors.white,
          //             ),
          //           ),
          //           onTap: () async {
          //             await APIs.auth.signOut();
          //             await GoogleSignIn().signOut();
          //           },
          //         )
          //       ];
          //     })
        ],

        title: Text(
          widget.user.name,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20.sp,
          ),
        ),
        // centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),

              // Profile Picture here

              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      double currentScale = 1.0;

                      double doubleTapScale = 2.2;
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return Scaffold(
                            backgroundColor: Colors.transparent,
                            body: GestureDetector(
                              onDoubleTap: () {
                                setState(() {
                                  currentScale = currentScale == 1.0
                                      ? doubleTapScale
                                      : 1.0;
                                });
                              },
                              child: Center(
                                child: InteractiveViewer(
                                  boundaryMargin: EdgeInsets.all(80),
                                  panEnabled: true,
                                  scaleEnabled: true,
                                  minScale: 1.0,
                                  maxScale: doubleTapScale,
                                  child: Transform.scale(
                                    scale: currentScale,
                                    child: CachedNetworkImage(
                                      placeholder: (context, url) {
                                        return Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: 20.sp,
                                        );
                                      },
                                      // height: 150.h,
                                      // width: 150.w,
                                      fit: BoxFit.cover,
                                      imageUrl: widget.user.image,
                                      errorWidget: (context, url, error) {
                                        return Icon(
                                          Icons.error,
                                          color: Colors.white,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(80),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: CachedNetworkImage(
                    placeholder: (context, url) {
                      return Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 20.sp,
                      );
                    },
                    height: 150.h,
                    width: 150.w,
                    fit: BoxFit.cover,
                    imageUrl: widget.user.image,
                    errorWidget: (context, url, error) {
                      return Icon(
                        Icons.error,
                        color: Colors.white,
                      );
                    },
                  ),
                ),
              ),

              10.verticalSpace,

              //  email here
              Text(
                "Name : ${widget.user.name}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  // fontWeight: FontWeight.w500,
                  // decoration: TextDecoration.underline,
                ),
              ),
              10.verticalSpace,
              Text(
                "Email : ${widget.user.email}",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15.sp,
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.underline,
                ),
              ),
              10.verticalSpace,
              Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "About : ${widget.user.about}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      shadows: [
                        Shadow(
                          offset: Offset(1, 1),
                          color: Colors.red,
                        ),
                      ],
                      // fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  3.horizontalSpace,
                ],
              ),

              // Write name here

              // Text(
              //   widget.user.name,
              //   style: TextStyle(
              //     color: Colors.white70,
              //     fontSize: 15,
              //   ),
              // ),

              10.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
