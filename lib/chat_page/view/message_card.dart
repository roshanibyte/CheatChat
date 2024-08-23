import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  @override
  Widget build(BuildContext context) {
    return APIs.user.uid == widget.message.fromID
        ? _greenMessage()
        : _buleMessage();
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
            margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.h),
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 10.h,
            ),
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
                    ? Text(
                        "${widget.message.msg}",
                        style: TextStyle(color: Colors.black),
                      )
                    : GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return CachedNetworkImage(
                                height: 200.h,
                                width: 250.w,
                                fit: BoxFit.fill,
                                imageUrl: widget.message.msg,
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
                        child: CachedNetworkImage(
                          height: 200.h,
                          width: 250.w,
                          fit: BoxFit.fill,
                          imageUrl: widget.message.msg,
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
      padding: EdgeInsets.all(10.w),
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
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 221, 245, 255),
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                      bottomLeft: Radius.circular(20.r),
                    ),
                  ),
                  child: widget.message.type == Type.text
                      ? Text(
                          "${widget.message.msg}",
                          style: TextStyle(color: Colors.black),
                        )
                      : GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return CachedNetworkImage(
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
                                );
                              },
                            );
                          },
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
                3.verticalSpace,
                Text(
                  MyDateUtil.getFormattedTime(
                      context: context, time: widget.message.sent),
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
