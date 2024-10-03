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
  void initState() {
    super.initState();
    controller.getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[300],
      appBar: AppBar(
        toolbarHeight: 65.h,
        elevation: 0,
        backgroundColor: Colors.green,
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
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => ControlledRiveAnimation(),
              //   ),
              // );
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
              color: Colors.green,
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
                itemCount: controller.status.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ClipOval(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: CircleAvatar(
                          maxRadius: 35,
                          backgroundColor: Colors.black,
                          child: Image.network(
                            controller.status[index],
                            fit: BoxFit.cover,
                            height: 70.h,
                            width: 70.w,
                          )),
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
                        ? Image.asset(
                            "assets/errorimage.jpg",
                            height: 160.h,
                            width: Get.width,
                            fit: BoxFit.fill,
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
                      '"${controller.jsonlist?.articles[index].title ?? ""}"',
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ).paddingSymmetric(
                      horizontal: 5.sp,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                );
              }),
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  controller.currentPage = index;
                  setState(() {});
                },
                scrollDirection: Axis.horizontal,
                height: 260.0,
                enlargeCenterPage: true,
                aspectRatio: 16 / 8,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                viewportFraction: 1,
              ),
            ),
            Text(
              "Ads : ",
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
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
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
