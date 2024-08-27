import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:testapp/chat_page/view/view_profile_screen_user.dart';
import 'package:testapp/model/chatmodel.dart';

class ProfileDialogue extends StatelessWidget {
  const ProfileDialogue({super.key, required this.user});
  final ChatUser user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: AlertDialog(
        backgroundColor: Colors.grey.shade600,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
          20,
        )),
        contentPadding: EdgeInsets.all(0),
        content: SizedBox(
          height: 200.h,
          width: 300.w,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    user.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
              ),
              Builder(builder: (context) {
                return Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      Get.to(
                        ViewProfileScreenUser(
                          user: user,
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.info,
                      color: Colors.blue,
                    ),
                  ),
                );
              }),
              Positioned(
                right: 70.w,
                top: 40.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(80.r),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: CachedNetworkImage(
                    height: 140.h,
                    width: 140.w,
                    fit: BoxFit.fill,
                    imageUrl: user.image,
                    errorWidget: (context, url, error) {
                      return Icon(
                        Icons.error,
                        color: Colors.white,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
