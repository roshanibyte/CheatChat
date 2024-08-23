import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:testapp/status_page/controller/status_page_controller.dart';

class StausPage extends StatefulWidget {
  const StausPage({super.key});

  @override
  State<StausPage> createState() => _StausPageState();
}

class _StausPageState extends State<StausPage> {
  
  final controller = Get.put(StatusPageController());
  static const List<String> _fruitOptions = <String>[
    'apple',
    'banana',
    'orange',
    'mango',
    'grapes',
    'watermelon',
    'kiwi',
    'strawberry',
    'sugarcane',
  ];
  // @override
  // void initState() {
  //   super.initState();
  //   getNews();
  // }

  // CarouselController buttonCarouselController = CarouselController();
  // ScrollController sController = ScrollController();
  // int value = 1;
  // int currentPage = 0;
  // NewsModal? jsonlist;

  // Future<void> getNews() async {
  //   String url =
  //       "https://newsapi.org/v2/top-headlines?country=in&apiKey=98ef0612a9ee40048f9b6e5b574e6e7c";

  //   // log("name ${jsonDecode(jsonDecode(jsonEncode(name)))}");

  //   try {
  //     final response = await Dio().get(url);
  //     // final response = await get(Uri.parse(url));
  //     log("message");
  //     if (response.statusCode == 200) {
  //       jsonlist = NewsModal.fromJson(response.data);
  //       setState(() {});
  //       log("List length ${jsonlist!.articles.length}");
  //     } else {
  //       log("no news= ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     log("Exception here = $e");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
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
          "Staus",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.verticalSpace,
            // Wrap(
            //   spacing: 5,
            //   runSpacing: 3,
            //   // list of length 3
            //   children: List.generate(
            //     3,
            //     (int index) {
            //       // choice chip allow us to
            //       // set its properties.
            //       return ChoiceChip(
            //         avatar: const CircleAvatar(
            //           radius: 40,
            //           child: FittedBox(
            //             child: Icon(
            //               Icons.person,
            //               size: 20,
            //               color: Colors.black,
            //             ),
            //           ),
            //         ),
            //         checkmarkColor: Colors.red,
            //         padding: const EdgeInsets.all(8),
            //         label: Text('Item $index'),
            //         // color of selected chip
            //         selectedColor: Colors.green,
            //         selected: controller.value == index,
            //         // onselected method
            //         onSelected: (bool selected) {
            //           setState(() {
            //             controller.value = (selected ? index : null)!;
            //           });
            //         },
            //       );
            //     },
            //   ).toList(),
            // ),

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
                            height: 140.h,
                            color: Colors.grey,
                            child: Center(
                              child: Icon(
                                Icons.question_mark,
                                color: Colors.red,
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

                // autoPlay: true,
                aspectRatio: 16 / 8,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                // autoPlayAnimationDuration: const Duration(milliseconds: 500),
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
            // SizedBox(
            //   height: 10,
            //   // width: 200,
            //   child: ListView.separated(
            //       shrinkWrap: true,
            //       controller: controller.sController,
            //       scrollDirection: Axis.horizontal,
            //       itemBuilder: (context, index) {
            //         return AnimatedContainer(
            //           height: 10,
            //           width: controller.currentPage == index ? 25 : 10,
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(10),
            //               color: controller.currentPage == index
            //                   ? Colors.red
            //                   : Colors.white),
            //           duration: const Duration(milliseconds: 500),
            //         );
            //       },
            //       separatorBuilder: (context, index) {
            //         return const SizedBox(
            //           width: 5,
            //         );
            //       },
            //       itemCount: controller.jsonlist?.articles.length ?? 0),
            // ),

            // 30.verticalSpace,

            // const Text(
            //   "Enter Fruit Name:",
            //   style: TextStyle(
            //     color: Colors.white,
            //   ),
            // ),
            // Autocomplete(
            //   optionsViewBuilder: (context, onSelected, options) {
            //     return Material(
            //       elevation: 2,
            //       color: Colors.grey,
            //       child: ListView.builder(
            //         shrinkWrap: true,
            //         itemCount: options.length,
            //         itemBuilder: (context, index) {
            //           final option = options.elementAt(index);
            //           return InkWell(
            //               child: Text(
            //                 option,
            //                 style: const TextStyle(
            //                   color: Colors.black,
            //                 ),
            //               ),
            //               onTap: () {
            //                 onSelected(
            //                   option,
            //                 );
            //               });
            //         },
            //       ),
            //     );
            //   },
            //   optionsBuilder: (TextEditingValue fruitTextEditingValue) {
            //     if (fruitTextEditingValue.text == '') {
            //       return const Iterable<String>.empty();
            //     }
            //     return _fruitOptions.where((String option) {
            //       return option.contains(
            //         fruitTextEditingValue.text.toLowerCase(),
            //       );
            //     });
            //   },
            //   onSelected: (String value) {
            //     debugPrint('You just selected $value');
            //   },
            //   fieldViewBuilder: (context, textEditingController, focusNode,
            //           onFieldSubmitted) =>
            //       const TextField(
            //     style: TextStyle(
            //       color: Colors.amber,
            //     ),
            //   ),
            // ),
            // 50.verticalSpace,
            Column(
              children: [
                SizedBox(
                  width: Get.width,
                  child: ClipRect(
                    child: Banner(
                      message: "Get 50% off",
                      // color: Colors.black,
                      textStyle:
                          const TextStyle(color: Colors.white, fontSize: 10),
                      location: BannerLocation.topStart,
                      child: Image.asset(
                        "assets/banner.png",
                        height: 200,
                        fit: BoxFit.fill,

                        // width: Get.width,
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
    // Container(
    //   height: Get.height,
    //   width: Get.width,
    //   color: Colors.amber,
    //   child:
    //    Center(
    //     child: ElevatedButton(
    //         onPressed: () {
    //           Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (context) => const ChatPage(),
    //               ));
    //         },
    //         child: const Text("Click Here")),
    //   ),
    // );
  }
}
