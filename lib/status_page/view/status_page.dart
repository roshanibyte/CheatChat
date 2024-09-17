import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:testapp/status_page/controller/status_page_controller.dart';
import 'package:testapp/status_page/paralax_effect.dart';

class StausPage extends StatefulWidget {
  const StausPage({super.key});

  @override
  State<StausPage> createState() => _StausPageState();
}

class _StausPageState extends State<StausPage> {
  final controller = Get.put(StatusPageController());

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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ParallaxEffect(),
                ),
              );
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
              color: Colors.black,
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
                      // Get.to(const Settings());
                    },
                  )
                ];
              })
        ],
        title: const Text(
          "Status",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.person,
            size: 30.sp,
            color: Colors.white,
          ),
        ),
        leadingWidth: 35.w,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.verticalSpace,
            const Text(
              "Recent Stories :",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            10.verticalSpace,
            SizedBox(
              height: Get.height * 0.1,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      maxRadius: 35,
                      backgroundColor: Colors.black,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Communites :",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CarouselSlider(
              // carouselController: buttonCarouselController,
              carouselController: controller.buttonCarouselController,
              items: List.generate(controller.jsonlist?.articles.length ?? 0,
                  (index) {
                return Column(
                  children: [
                    controller.jsonlist?.articles[index].urlToImage == null
                        ? Container(
                            height: 170.h,
                            color: Colors.grey,
                            child: Center(
                              child: Icon(
                                Icons.image,
                                color: Colors.white,
                                size: 30.sp,
                              ),
                            ),
                          )
                        : Image.network(
                            controller.jsonlist?.articles[index].urlToImage ??
                                "",
                            height: 150,
                            width: Get.width,
                            fit: BoxFit.fill,
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      controller.jsonlist?.articles[index].url ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.blue,
                      ),
                    )
                  ],
                );
              }),
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  controller.currentPage = index;
                  setState(() {});
                },
                scrollDirection: Axis.horizontal,
                height: 220.0,
                enlargeCenterPage: true,
                aspectRatio: 16 / 8,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                viewportFraction: 1,
              ),
            ),
            Text(
              "Ads :",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
              ),
            ),
            10.verticalSpace,
            Column(
              children: [
                SizedBox(
                  width: Get.width,
                  child: ClipRect(
                    child: Banner(
                      message: "Get 50% off",
                      textStyle:
                          const TextStyle(color: Colors.white, fontSize: 10),
                      location: BannerLocation.topStart,
                      child: Image.asset(
                        "assets/banner.png",
                        height: 200,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            100.verticalSpace,
          ],
        ),
      ),
    );
  }
}
