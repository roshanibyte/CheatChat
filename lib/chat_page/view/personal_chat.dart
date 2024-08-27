import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testapp/apis/apis.dart';
import 'package:testapp/chat_page/controller/chat_page_controller.dart';
import 'package:testapp/chat_page/view/message_card.dart';
import 'package:testapp/chat_page/view/view_profile_screen_user.dart';
import 'package:testapp/helper/my_date_util.dart';
import 'package:testapp/model/chatmodel.dart';
import 'package:testapp/model/message_model.dart';

class PersonalChatView extends StatefulWidget {
  final ChatUser user;
  const PersonalChatView({super.key, required this.user});

  @override
  State<PersonalChatView> createState() => _PersonalChatViewState();
}

class _PersonalChatViewState extends State<PersonalChatView> {
  final FocusNode focus = FocusNode();
  bool isOpened = false;
  @override
  void initState() {
    super.initState();
    focus.addListener(
      () {
        if (focus.hasFocus) {
          isOpened = true;
        } else {
          isOpened = false;
        }
        setState(() {});
      },
    );
  }

  final controller = Get.put(ChatPageController());
  String imagePath = "";
  bool isImage = false;
  bool isUploadingImage = false;
  File? image;
  // For storing all Messages from the chat
  List<Message> _list = [];
  // For handing text message
  final _textcontoller = TextEditingController();
  bool isShowEmoji = false;
  bool isRecording = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(
        onWillPop: () {
          if (isShowEmoji) {
            setState(() {
              isShowEmoji = !isShowEmoji;
            });
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.videocam,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => const TestPage()));
                },
                icon: const Icon(
                  Icons.call,
                  color: Colors.white,
                ),
              ),
              PopupMenuButton(
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      onTap: () {},
                      child: Text(
                        "Settings",
                      ),
                    ),
                  ];
                },
              ),
            ],
            leadingWidth: 25,
            title: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ViewProfileScreenUser(user: widget.user),
                    ));
              },
              child: StreamBuilder(
                stream: APIs.getUserInfo(widget.user),
                builder: (context, snapshot) {
                  final data = snapshot.data?.docs;
                  final list =
                      data?.map((e) => ChatUser.fromJson(e.data())).toList() ??
                          [];

                  return Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          25,
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: CachedNetworkImage(
                          height: 40.h,
                          width: 40.w,
                          fit: BoxFit.cover,
                          imageUrl: list.isNotEmpty
                              ? list[0].image
                              : widget.user.image,
                          errorWidget: (context, url, error) {
                            return Icon(
                              Icons.error,
                              color: Colors.white,
                            );
                          },
                        ),
                      ),
                      10.horizontalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getFirstWord(
                              list.isNotEmpty ? list[0].name : widget.user.name,
                            ).toString(),
                            style: TextStyle(fontSize: 15.sp),
                          ),
                          3.verticalSpace,
                          Text(
                            list.isNotEmpty
                                ? list[0].isOnline
                                    ? "online"
                                    : MyDateUtil.getLastActiveTime(
                                        context: context,
                                        lastActive: list[0].lastActive,
                                      )
                                : MyDateUtil.getLastActiveTime(
                                    context: context,
                                    lastActive: widget.user.lastActive),
                            // "Last seen not availabe",
                            style: TextStyle(
                                fontSize: 8.sp, color: Colors.white54),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            backgroundColor: Colors.black,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
              ),
            ),
          ),
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          body: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                "assets/chatBG.jpg",
                width: Get.width,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              Column(
                children: [
                  Expanded(
                    child: StreamBuilder(
                        stream: APIs.getAllMessage(widget.user),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            // if data is loading
                            case ConnectionState.waiting:
                            case ConnectionState.none:
                              return SizedBox();

                            case ConnectionState.active:
                            case ConnectionState.done:

                              // log("hasdata: ${snapshot.hasData}");
                              final data = snapshot.data?.docs;

                              _list = data
                                      ?.map((e) => Message.fromJson(e.data()))
                                      .toList() ??
                                  [];
                              if (_list.isNotEmpty) {
                                return ListView.builder(
                                  // physics: BouncingScrollPhysics(),
                                  reverse: true,
                                  itemCount:
                                      //  isSearching == true
                                      //     ? searchList.length
                                      //     :
                                      _list.length,
                                  // controller.jsonList == null
                                  //     ? 0
                                  //     : controller.jsonList.length,
                                  itemBuilder: (context, index) {
                                    return
                                        //  ChatUserCard(
                                        //   user: isSearching == true
                                        //       ? searchList[index]
                                        //       :
                                        MessageCard(
                                      message: _list[index],
                                    );
                                  },
                                );
                              } else {
                                return Center(
                                  child: Text(
                                    "Say Hii 👋",
                                    style: TextStyle(
                                      color: Colors.white60,
                                      fontSize: 30,
                                    ),
                                  ),
                                );
                              }

                            // log("Data: ${i.data()}");
                          }
                        }),
                  ),
                  if (isUploadingImage == true)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 10.h),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  chatInput(),
                  if (true)
                    SizedBox(
                      height: isOpened
                          ? MediaQuery.of(context).viewInsets.bottom
                          : 0,
                    ),
                  if (isShowEmoji)
                    EmojiPicker(
                      textEditingController: _textcontoller,
                      config: Config(
                        searchViewConfig: SearchViewConfig(),
                        height: 256,
                        emojiViewConfig: EmojiViewConfig(
                          columns: 7,
                          backgroundColor: Colors.grey.shade800,
                          emojiSizeMax: 28 * (Platform.isIOS ? 1.20 : 1.0),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? getFirstWord(String sentence) {
    List<String> words = sentence.split(' ');
    if (words.isNotEmpty) {
      return words[0];
    }
    return null; // Or return an empty string, or handle as needed
  }

  Widget chatInput() {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Card(
            // color: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      FocusScope.of(context).unfocus();
                      isShowEmoji = !isShowEmoji;
                    });
                  },
                  icon: Icon(
                    Icons.emoji_emotions,
                    color: isRecording ? Colors.red : Colors.blue,
                  ),
                ),
                Expanded(
                  child: TextField(
                    focusNode: focus,
                    onChanged: (value) => isImage = false,
                    onTap: () {
                      if (isShowEmoji)
                        setState(
                          () {
                            isShowEmoji = !isShowEmoji;
                          },
                        );
                    },
                    controller: _textcontoller,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    readOnly: isRecording ? true : false,
                    style: TextStyle(color: Colors.black),
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                      hintText: isRecording
                          ? "Record Your Audio..."
                          : "Type Something...",
                      hintStyle: TextStyle(
                          color: isRecording ? Colors.red : Colors.blue),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();

                    //pick an Image
                    final List<XFile> images =
                        await picker.pickMultiImage(imageQuality: 40);
                    for (var i in images) {
                      log("path of the image ${i.path}");
                      setState(() => isUploadingImage = true);

                      isImage = true;
                      await APIs.sendChatImage(
                        widget.user,
                        File(i.path),
                      );
                      setState(() => isUploadingImage = false);
                    }
                  },
                  icon: Icon(
                    Icons.image,
                    color: isRecording ? Colors.red : Colors.blue,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();

                    //pick an Image
                    final image = await picker.pickImage(
                        source: ImageSource.camera, imageQuality: 40);
                    if (image != null) {
                      log("path of the image ${image.path}");

                      setState(() => isUploadingImage = true);
                      isImage = true;
                      await APIs.sendChatImage(
                        widget.user,
                        File(image.path),
                      );
                      setState(() => isUploadingImage = false);
                    }
                  },
                  icon: Icon(
                    Icons.camera_alt_outlined,
                    color: isRecording ? Colors.red : Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
        MaterialButton(
          minWidth: 0,
          height: 45.h,
          shape: CircleBorder(),
          color: isRecording ? Colors.red : Colors.blue,

          // color: Colors.blue,
          onLongPress: () {
            setState(() {
              isRecording = !isRecording;
            });
          },
          onPressed: () {
            if (_textcontoller.text.isNotEmpty) {
              APIs.sendMessage(widget.user, _textcontoller.text,
                  isImage ? Type.image : Type.text);
              _textcontoller.text = "";
            }
          },
          child: Center(
            child: Icon(
              isRecording ? Icons.record_voice_over_outlined : Icons.send,
              size: 30.sp,
              color:
                  // isRecording ? Colors.red :
                  Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
