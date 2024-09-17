import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testapp/apis/apis.dart';
import 'package:testapp/auth/log_in_page/views/log_in_page.dart';
import 'package:testapp/model/chatmodel.dart';
import 'package:testapp/setting.dart';

class ProofilePageView extends StatefulWidget {
  final ChatUser user;

  const ProofilePageView({super.key, required this.user});

  @override
  State<ProofilePageView> createState() => _ProofilePageViewState();
}

class _ProofilePageViewState extends State<ProofilePageView> {
  final formKey = GlobalKey<FormState>();
  String imagePath = "";
  final picker = ImagePicker();
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.9),

      // Logout button here

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.redAccent,
        onPressed: () async {
          await APIs.auth.signOut().then((value) async {
            await GoogleSignIn().signOut().then((value) {
              Get.offAll(LogInPage());
            });
          });
        },
        label: Text("Logout"),
        icon: Icon(
          Icons.logout,
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 65.h,

        elevation: 1,
        leadingWidth: 30,

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
                      Get.to(const Settings());
                    },
                  ),

                  // Logout button
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

        title: const Text(
          "Profile Page",
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w500,
          ),
        ),
        // centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),

                // Profile Picture here

                Stack(
                  children: [
                    image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(
                              80,
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Image.file(
                              File(imagePath),
                              height: 150.h,
                              width: 150.w,
                              fit: BoxFit.cover,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(
                              80,
                            ),
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
                    Positioned(
                      bottom: 0.h,
                      right: -20.w,
                      child: MaterialButton(
                        elevation: 2,
                        onPressed: () {
                          showBottomSheet();
                        },
                        shape: CircleBorder(),
                        color: Colors.white,
                        child: Icon(
                          Icons.edit,
                        ),
                      ),
                    )
                  ],
                ),
                10.verticalSpace,

                //  email here

                Text(
                  widget.user.email,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                  ),
                ),

                // Write name here
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 10.h,
                  ),
                  child: TextFormField(
                    onTapOutside: (event) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    onSaved: (val) => APIs.me.name = val ?? "",
                    validator: (val) => val != null && val.isNotEmpty
                        ? null
                        : "Required Fields",
                    initialValue: widget.user.name,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          21,
                        ),
                        borderSide: BorderSide(
                          color: Colors.white60,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          21,
                        ),
                        borderSide: BorderSide(
                          color: Colors.white38,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.white54,
                      ),
                      hintText: "Mr. Happy Singh",
                      hintStyle: TextStyle(
                        color: Colors.white54,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          21,
                        ),
                      ),
                    ),
                  ),
                ),

                // Write about here

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 10.h,
                  ),
                  child: TextFormField(
                    initialValue: widget.user.about,
                    onTapOutside: (event) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    onSaved: (val) => APIs.me.about = val ?? "",
                    validator: (val) => val != null && val.isNotEmpty
                        ? null
                        : "Required Fields",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 4),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          21,
                        ),
                        borderSide: BorderSide(
                          color: Colors.white60,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          21,
                        ),
                        borderSide: BorderSide(
                          color: Colors.white38,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.info,
                        color: Colors.white54,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.white54,
                      ),
                      hintText: "Write your about",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          21,
                        ),
                      ),
                    ),
                  ),
                ),
                10.verticalSpace,

                //  Profile Update button

                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    minimumSize: Size(
                      Get.width * 0.3,
                      35.h,
                    ),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      APIs.updateUserInfo().then((value) {
                        Get.snackbar(
                          dismissDirection: DismissDirection.horizontal,
                          "Updated",
                          "Profile Updated Successfully",
                          backgroundColor: Colors.white60,
                        );
                      });
                      formKey.currentState!.save();
                      log("Inside Validator");
                    }
                  },
                  icon: Icon(
                    Icons.edit,
                    size: 15,
                  ),
                  label: Text(
                    "Update",
                    style: TextStyle(
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // bottomsheet for the selection of profile picture

  void showBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(21),
          topRight: Radius.circular(21),
        ),
      ),
      context: context,
      builder: (_) {
        return Container(
          height: 130.h,
          child: ListView(
            shrinkWrap: true,
            children: [
              10.verticalSpace,
              Text(
                "Pick Your Profile Picture",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 21.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // button for the image selction form the camera

                  ElevatedButton.icon(
                    style: ButtonStyle(
                      minimumSize: WidgetStatePropertyAll(
                        Size(100, 50),
                      ),
                      backgroundColor: WidgetStatePropertyAll(Colors.black45),
                    ),
                    onPressed: () async {
                      final pickedFile =
                          await picker.pickImage(source: ImageSource.camera);
                      if (pickedFile != null) {
                        setState(() {
                          imagePath = pickedFile.path;
                        });

                        APIs.updateProfilePicture(
                          File(imagePath),
                          () => setState(() {}),
                        );
                        Navigator.pop(context);
                      }
                    },
                    icon: Image.asset(
                      "assets/camera_icon.png",
                      height: 40.h,
                      width: 40.w,
                    ),
                    label: Text(
                      "Camera",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),

                  // button for the image selction from the gallery

                  ElevatedButton.icon(
                    style: ButtonStyle(
                      minimumSize: WidgetStatePropertyAll(
                        Size(100, 50),
                      ),
                      backgroundColor: WidgetStatePropertyAll(Colors.black45),
                    ),
                    onPressed: () async {
                      final pickedFile =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        setState(() {
                          imagePath = pickedFile.path;
                        });
                        APIs.updateProfilePicture(
                          File(imagePath),
                          () => setState(() {}),
                        );

                        Navigator.pop(context);
                      }
                    },
                    icon: Image.asset(
                      "assets/galleryicon.png",
                      height: 40.h,
                      width: 40.w,
                    ),
                    label: Text(
                      "Gallery",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
