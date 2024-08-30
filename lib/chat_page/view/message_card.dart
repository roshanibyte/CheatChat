import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:testapp/apis/apis.dart';
import 'package:testapp/helper/my_date_util.dart';
import 'package:testapp/model/message_model.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({super.key, required this.message});
  final Message message;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  bool isSentAt = false;
  bool isReadAt = false;
  @override
  Widget build(BuildContext context) {
    final isMe = APIs.user.uid == widget.message.fromID;
    return InkWell(
        onLongPress: () {
          showBottomSheet(isMe, widget.message.msg);
        },
        child: isMe ? _greenMessage() : _buleMessage());
  }

// sender message or other user message
  Widget _buleMessage() {
    if (widget.message.read.isEmpty) {
      APIs.updateMessageReadStatus(widget.message);
      // log("Message updates: ${widget.message}");
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.h),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              color: const Color.fromARGB(255, 221, 245, 255),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r),
              ),
            ),
            child: widget.message.type == ""
                ? CircularProgressIndicator()
                : widget.message.type == Type.text
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                          vertical: 5.h,
                        ),
                        child: Text(
                          "${widget.message.msg}",
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    : widget.message.type == Type.text
                        ? Text(
                            "${widget.message.msg}",
                            style: TextStyle(color: Colors.black),
                          )
                        : GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return ClipRRect(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    borderRadius: BorderRadius.circular(15.r),
                                    child: CachedNetworkImage(
                                      height: 150.h,
                                      width: 200.w,
                                      fit: BoxFit.contain,
                                      imageUrl: widget.message.msg,
                                      placeholder: (context, url) {
                                        return Icon(Icons.image);
                                      },
                                      errorWidget: (context, url, error) {
                                        return Icon(
                                          Icons.error,
                                          color: Colors.white,
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            child: ClipRRect(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              borderRadius: BorderRadius.circular(20.r),
                              child: CachedNetworkImage(
                                height: 150.h,
                                width: 200.w,
                                fit: BoxFit.cover,
                                imageUrl: widget.message.msg,
                                placeholder: (context, url) {
                                  return Icon(Icons.image);
                                },
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
        10.horizontalSpace,
        Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Text(
              MyDateUtil.getFormattedTime(
                  context: context, time: widget.message.sent),
              style: TextStyle(color: Colors.grey),
            )

            // Text(
            //   MyDateUtil.getFormattedDate(context, widget.message.sent),
            //   style: TextStyle(color: Colors.grey),
            // ),
            )
      ],
    );
  }

// our message or user message
  _greenMessage() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // double tick for the read of the messase
              if (widget.message.read.isEmpty)
                Icon(
                  Icons.done,
                  color: Colors.blue,
                ),

              if (widget.message.read.isNotEmpty)
                Icon(
                  Icons.done_all,
                  color: Colors.blue,
                ),
            ],
          ),
          10.horizontalSpace,
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // padding: EdgeInsets.symmetric(
                  //   horizontal: 10.w,
                  //   vertical: 10.h,
                  // ),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 221, 245, 255),
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                      bottomLeft: Radius.circular(20.r),
                      // bottomRight: Radius.circular(20.r),
                    ),
                  ),
                  child: widget.message.type == Type.text
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 5.h,
                          ),
                          child: Text(
                            "${widget.message.msg}",
                            style: TextStyle(color: Colors.black),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return CachedNetworkImage(
                                  // height: 150.h,
                                  // width: 200.w,
                                  fit: BoxFit.contain,
                                  imageUrl: widget.message.msg,
                                  placeholder: (context, url) {
                                    return Icon(Icons.image);
                                  },
                                  errorWidget: (context, url, error) {
                                    return Icon(
                                      Icons.error,
                                      color: Colors.white,
                                    );
                                  },
                                );
                              },
                            );
                          },
                          child: ClipRRect(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            borderRadius: BorderRadius.circular(20),
                            child: CachedNetworkImage(
                              height: 150.h,
                              width: 200.w,
                              fit: BoxFit.cover,
                              imageUrl: widget.message.msg,
                              placeholder: (context, url) {
                                return Icon(Icons.image);
                              },
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
                3.verticalSpace,
                Text(
                  MyDateUtil.getFormattedTime(
                      context: context, time: widget.message.sent),
                  style: TextStyle(color: Colors.grey, fontSize: 11.sp),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // bottomsheet for the selection of profile picture

  void showBottomSheet(bool isMe, String msg) {
    showModalBottomSheet(
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.r),
          topRight: Radius.circular(15.r),
        ),
      ),
      context: context,
      builder: (_) {
        log("$msg");
        return ListView(
          shrinkWrap: true,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 15.h, horizontal: 120.w)
                  .copyWith(bottom: 10.h),
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(15.r),
              ),
            ),
            widget.message.type == Type.image
                ? optionItems(
                    icon: Icons.download,
                    Iconcolor: Colors.blue,
                    text: "Save Image",
                    onTap: () async {
                      saveImageToGallery(widget.message.msg).then(
                        (value) {
                          Get.back();
                        },
                      );
                    })
                : optionItems(
                    icon: Icons.copy_all_outlined,
                    Iconcolor: Colors.blue,
                    text: "Copy Text",
                    onTap: () async {
                      try {
                        await Clipboard.setData(
                          ClipboardData(text: msg),
                        ).then((_) {
                          Fluttertoast.showToast(
                            msg: "Copied to clipboard",
                          );
                        });
                      } catch (e) {
                        log("Copy exception here: $e");
                      }
                    }),
            Divider(
              color: Colors.black54,
              endIndent: 20.w,
              indent: 20.w,
            ),
            if (widget.message.type == Type.text && isMe)
              optionItems(
                  icon: Icons.edit,
                  Iconcolor: Colors.blue,
                  text: "Edit Message",
                  onTap: () {
                    // content: Container(
                    //   height: 100.h,
                    //   width: 150.w,
                    //   color: Colors.white,
                    // ),
                    Navigator.pop(context);

                    showUpdatedMSGDialogue();
                  }),
            if (isMe)
              optionItems(
                  icon: Icons.delete,
                  Iconcolor: Colors.red,
                  text: "Delete Message",
                  onTap: () {
                    APIs.deleteMessage(widget.message).then((value) {
                      Navigator.pop(context);
                    });
                  }),
            if (isMe)
              Divider(
                endIndent: 20.w,
                indent: 20.w,
                color: Colors.black54,
              ),
            optionItems(
                icon: Icons.remove_red_eye,
                Iconcolor: Colors.blue,
                text: "Sent At",
                onTap: () {
                  Fluttertoast.showToast(
                      textColor: Colors.green,
                      backgroundColor: Colors.white,
                      msg:
                          "Sent At:${MyDateUtil.getFormattedTime(context: context, time: widget.message.sent)}");
                  Navigator.pop(context);
                }),
            optionItems(
              icon: Icons.remove_red_eye,
              Iconcolor: Colors.green,
              text: "Read At",
              onTap: () {
                if (widget.message.read.isEmpty) {
                  Fluttertoast.showToast(msg: "Read is empty");
                } else {
                  Fluttertoast.showToast(
                      textColor: Colors.green,
                      backgroundColor: Colors.white,
                      msg:
                          "Read At:${MyDateUtil.getFormattedTime(context: context, time: widget.message.read)}");
                }
                Navigator.pop(context);
              },
            ),
            20.verticalSpace,
          ],
        );
      },
    );
  }

  // Function to save image to gallery
  Future<void> saveImageToGallery(String imageUrl) async {
    await requestStoragePermission();
    try {
      // Get the image data from the URL
      final response = await get(Uri.parse(imageUrl));
      final Uint8List imageData = response.bodyBytes;

      // Save the image to the gallery
      final result = await ImageGallerySaver.saveImage(imageData);
      log("Image saved to gallery: $result");

      // Show a success toast
      Fluttertoast.showToast(msg: "Image saved to gallery!");
    } catch (e) {
      log("Failed to save image: $e");
      Fluttertoast.showToast(msg: "Failed to save image.");
    }
  }

  Future<void> requestStoragePermission() async {
    // if (await Permission.storage.request().isGranted) {

    // } else {

    //   if (await Permission.storage.request().isDenied) {
    //  Fluttertoast.showToast(msg: "Allow permission request to save the image");
    //   }
    // }

    // For Android 10 and above
    if (await Permission.manageExternalStorage.request().isGranted) {
      Fluttertoast.showToast(msg: "Permission Granted");
    } else {
      "";
      // Fluttertoast.showToast(msg: "Allow Storage Permission to save the Image");
    }
  }

  void showUpdatedMSGDialogue() {
    String updatedMsg = widget.message.msg;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.message,
              size: 15.sp,
              color: Colors.grey,
            ),
            5.horizontalSpace,
            Text(
              "Update Message",
              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        content: TextFormField(
          initialValue: updatedMsg,
          onChanged: (value) => updatedMsg = value,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                20.r,
              ),
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
            onPressed: () {
              APIs.updateMessage(widget.message, updatedMsg);
              Navigator.pop(context);
            },
            child: Text(
              "Update",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class optionItems extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final Color? Iconcolor;

  optionItems(
      {super.key,
      required this.icon,
      required this.text,
      required this.onTap,
      this.Iconcolor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Row(
          children: [
            Icon(
              icon,
              color: Iconcolor,
            ),
            20.horizontalSpace,
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
