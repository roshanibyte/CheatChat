import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:testapp/apis/apis.dart';
import 'package:testapp/chat_page/view/personal_chat.dart';
import 'package:testapp/chat_page/view/profile_dialogue.dart';
import 'package:testapp/helper/my_date_util.dart';
import 'package:testapp/model/chatmodel.dart';
import 'package:testapp/model/message_model.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser user;
  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

Message? message;

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.transparent,
        // elevation: 3,
        elevation: 0,
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),

        // shape:

        // StadiumBorder(
        //   side: BorderSide(color: Colors.black38),
        // ),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.white30,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: StreamBuilder(
          stream: APIs.getLastMessage(widget.user),
          builder: (context, snapshot) {
            final data = snapshot.data?.docs;
            final list =
                data?.map((e) => Message.fromJson(e.data())).toList() ?? [];
            if (list.isNotEmpty) message = list[0];

            return ListTile(
                onTap: () {
                  Get.to(PersonalChatView(user: widget.user));
                },
                leading: InkWell(
                  onTap: () {
                    Get.to(ProfileDialogue(
                      user: widget.user,
                    ));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      25,
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: CachedNetworkImage(
                      height: 50.h,
                      width: 50.w,
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
                title: Text(
                  widget.user.name,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                subtitle: Row(
                  children: [
                    Expanded(
                      child: Text(
                        message != null
                            ? message!.type == Type.image
                                ? " 📷 Image"
                                : message!.msg
                            : widget.user.about,
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                trailing: message == null
                    ? null
                    : message!.read.isEmpty && message!.fromID != APIs.user.uid
                        ? Container(
                            height: 10.h,
                            width: 10.w,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(
                                5,
                              ),
                            ),
                          )
                        : Text(
                            MyDateUtil.getLastMessageTime(
                                context: context, time: message!.sent),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )

                // Text(
                //     MyDateUtil.getLastMessageTime(
                //         context, message!.sent),
                //     style: TextStyle(
                //       color: Colors.white,
                //     ),
                //   ),
                );
          },
        ));
  }
}
