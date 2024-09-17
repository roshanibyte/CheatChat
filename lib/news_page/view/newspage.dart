import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:testapp/chat_page/view/kids_game/game_home_dart.dart';
import 'package:testapp/chat_page/view/tic_toc_toe/tic_toc_toe.dart';
import 'package:testapp/news_page/controller/news_page_controller.dart';
import 'package:testapp/stopwatch.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final controller = Get.put(NewsPAgeController());
  // @override
  // void initState() {
  //   super.initState();
  //   getData();
  // }

  // NewsModal? jsonlist;

  // getData() async {
  //   String url =
  //       "https://newsapi.org/v2/top-headlines?country=in&apiKey=98ef0612a9ee40048f9b6e5b574e6e7c";
  //   try {
  //     final response = await get(
  //       Uri.parse(url),
  //     );
  //     log(response.body);

  //     if (response.statusCode == 200) {
  //       jsonlist = newsModalFromJson(response.body);
  //       log("$jsonlist");
  //       setState(() {});
  //     } else {
  //       log("${response.statusCode}");
  //     }
  //     log("$response");
  //   } catch (e) {
  //     log("catch is -- $e");
  //   }
  // }

  // Future<void> _launchUrl({required int index}) async {
  //   final Uri urls = Uri.parse(jsonlist?.articles[index].url.toString() ?? '');
  //   if (await canLaunchUrl(urls)) {
  //     log("This is the url = $urls");

  //     await launchUrl(urls, mode: LaunchMode.inAppBrowserView);
  //   } else {
  //     throw Exception('Could not launch $urls');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.9),
      appBar: AppBar(
        toolbarHeight: 65.h,

        backgroundColor: Colors.black,
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
          IconButton(
              onPressed: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => const TestPage()));
              },
              icon: const Icon(
                Icons.more_vert_rounded,
                color: Colors.white,
              ))
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
      body: ListView.builder(
        itemCount: controller.jsonlist?.articles.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              CachedNetworkImage(
                imageUrl: controller.jsonlist?.articles[index].urlToImage ?? '',
                // controller.jsonlist?.articles[index].urlToImage
                //         .toString() ??
                //     "",
                errorWidget: (context, url, error) {
                  return Image.asset(
                    "assets/errorimage.jpg",
                    height: 180,
                    fit: BoxFit.fill,
                    width: Get.width,
                    // cacheWidth: Get.,
                  );
                  // Shimmer(
                  //   gradient: const LinearGradient(
                  //       colors: [
                  //         Colors.white12,
                  //         Colors.grey,
                  //         Colors.white38,
                  //         Colors.grey
                  //       ],
                  //       begin: Alignment.topLeft,
                  //       end: Alignment.bottomRight,
                  //       stops: [
                  //         -0.4,
                  //         -0.9,
                  //         0.5,
                  //         1,
                  //       ]),
                  //   child: Image.asset(
                  //     "assets/palceholderImage.png",
                  //     height: 150,

                  //     cacheHeight: 150,
                  //     // cacheWidth: Get.,
                  //   ),
                  // );
                },
                placeholder: (context, url) {
                  return Image.asset(
                    "assets/palceholderImage.png",
                    height: 150,
                    fit: BoxFit.fill,
                    width: Get.width,
                    // cacheWidth: Get.,
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  maxLines: 4,
                  controller.jsonlist?.articles[index].content == null
                      ? controller.jsonlist?.articles[index].title.toString() ??
                          ""
                      : controller.jsonlist?.articles[index].content
                              .toString() ??
                          "",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  controller.launchUrls(index: index);
                },
                child: Text(
                  maxLines: 2,
                  controller.jsonlist?.articles[index].url.toString() ?? "",
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
                child: Text(
                  maxLines: 4,
                  controller.jsonlist?.articles[index].author == null
                      ? ""
                      : "(By- ${controller.jsonlist?.articles[index].author})",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
