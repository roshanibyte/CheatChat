import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:testapp/chat_page/view/kids_game/game_home_dart.dart';
import 'package:testapp/chat_page/view/tic_toc_toe/tic_toc_toe.dart';
import 'package:testapp/news_page/controller/news_page_controller.dart';
import 'package:testapp/news_page/view/video_player_view.dart';
import 'package:testapp/stopwatch.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final controller = Get.put(NewsPAgeController());
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[300],
      appBar: AppBar(
        toolbarHeight: 65.h,
        backgroundColor: Colors.green,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(TicTacToeScreen());
            },
            icon: const Icon(
              Icons.games,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              Get.to(GameHomePage());
            },
            icon: const Icon(
              Icons.play_circle_sharp,
              color: Colors.white,
            ),
          ),
          IconButton(
              onPressed: () {
                Get.to(StopWatchPage());
              },
              icon: const Icon(
                Icons.run_circle,
                color: Colors.white,
              )),
          PopupMenuButton(
              onSelected: (value) {
                // Get.to(const Settings());
              },
              color: Colors.green,
              icon: const Icon(
                Icons.more_vert_rounded,
                color: Colors.white,
              ),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: const Text(
                      "Video Player",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Get.to(
                        () => YoutubeUrlPlayer(),
                      );
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
                      "Settings",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      // Get.to(const Settings());
                    },
                  )
                ];
              }),
        ],
        leadingWidth: 30.w,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: const Icon(
            Icons.newspaper,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Latest News",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.jsonlist?.articles == null ||
            controller.jsonlist!.articles.isEmpty) {
          return Center(child: Text("No articles available"));
        }

        return ListView.builder(
          itemCount: controller.jsonlist!.articles.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                const SizedBox(height: 10),
                CachedNetworkImage(
                  imageUrl:
                      controller.jsonlist!.articles[index].urlToImage ?? '',
                  errorWidget: (context, url, error) {
                    return Image.asset(
                      "assets/errorimage.jpg",
                      height: 180,
                      width: Get.width,
                      fit: BoxFit.fill,
                    );
                  },
                  placeholder: (context, url) {
                    return Image.asset(
                      "assets/palceholderImage.png",
                      height: 150,
                      width: Get.width,
                      fit: BoxFit.fill,
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    controller.jsonlist?.articles[index].content?.toString() ??
                        controller.jsonlist?.articles[index].title.toString() ??
                        "",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                InkWell(
                  onTap: () {
                    controller.launchUrls(index: index);
                  },
                  child: Text(
                    maxLines: 2,
                    controller.jsonlist?.articles[index].url ?? "",
                    style: const TextStyle(color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
                  child: Text(
                    controller.jsonlist!.articles[index].author != null
                        ? "(By- ${controller.jsonlist!.articles[index].author})"
                        : "",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
