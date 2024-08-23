import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
// import 'package:news_app/routes/approutes.dart';
// import 'package:news_app/view/drawer/bottomsheet/bottomsheet.dart';
// import 'package:news_app/view/news_page/controller/news_controller.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(NewsController());

    return Scaffold(
     
      resizeToAvoidBottomInset: false,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        // itemCount: controller.data?.articles.length,
        itemBuilder: (context, index) {
          // return news(index: index);
        },
      ),
    );
  }
}

// news({
//   required int index,
// }) {
//   final controller = Get.find<NewsController>();
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [

//       ListView(
      
//       ),
//       SizedBox(
//         height: 300,
//         child: Stack(
//           children: [
//             SizedBox(
//               height: 290,
//               width: Get.width,
//               child: CachedNetworkImage(
//                 imageUrl: controller.data?.articles[index].urlToImage
//                         .toString() ??
//                     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyrM7HACYGILY3XwSlD28M-56_1suNI6_MeQ&usqp=CAU",
//                 fit: BoxFit.cover,
//                 placeholder: (context, url) {
//                   return Shimmer.fromColors(
//                     baseColor: const Color(0xff808080),
//                     highlightColor: const Color(0xffB2BEB5),
//                     child: Container(
//                       color: Colors.grey,
//                       height: 290,
//                       width: Get.width,
//                     ),
//                   );
//                 },
//                 errorWidget: (context, url, error) {
//                   return Image.asset(
//                     "assets/images/entertainment.jpg",
//                     fit: BoxFit.cover,
//                   );
//                 },
//               ),
//             ),
//             Positioned(
//               bottom: 2.5,
//               left: 30,
//               child: Container(
//                 height: 20,
//                 width: 86,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: const Color(0xFF4A43EC)),
//                 child: InkWell(
//                     onTap: () {
//                       Get.toNamed(AppRoutes.homePage);
//                     },
//                     child: Center(
//                       child: textwidget(data: "Top Feed", color: Colors.white),
//                     )),
//               ),
//             ),
//             Positioned(
//               bottom: 2.5,
//               left: 307,
//               child: InkWell(
//                 onTap: () {
//                   Get.bottomSheet(
//                       isScrollControlled: true, const BottomSheets());
//                 },
//                 child: Container(
//                   height: 20,
//                   width: 20,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(45),
//                       color: const Color(0xFF4A43EC)),
//                   child: const Center(
//                       child: Icon(
//                     Icons.share,
//                     color: Colors.white,
//                     size: 12,
//                   )),
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 2.5,
//               left: 331,
//               child: Container(
//                   height: 20,
//                   width: 20,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(45),
//                       color: const Color(0xFF4A43EC)),
//                   child: Center(
//                     child: SvgPicture.asset("assets/images/saveicon.svg"),
//                   )),
//             ),
//           ],
//         ),
//       ),
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(
//               height: 5,
//             ),
//             textwidget(
//               data: controller.data?.articles[index].title ?? "",
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//             ),
//             const SizedBox(
//               height: 5,
//             ),
//             textwidget(
//               data: controller.data?.articles[index].content.toString() ?? "",
//               fontSize: 14,
//               color: Colors.black,
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             textwidget(
//                 data: "For Full News Click on this link: ",
//                 fontWeight: FontWeight.bold),

//             InkWell(
//               onTap: () async {
//                 launchUrlString(
//                   controller.data?.articles[index].url ?? "Google.com",
//                   mode: LaunchMode.externalApplication,
//                 );
//               },
//               child: textwidget(
//                   data: controller.data?.articles[index].url.toString() ?? "",
//                   color: Colors.blue,
//                   decoration: TextDecoration.underline,
//                   decorationColor: Colors.blue),
//             ),
//             5.verticalSpace,
//             textwidget(
//               data: "Swipe Up for more at Sportskeeda /few hours ago",
//               fontWeight: FontWeight.w500,
//               fontSize: 12,
//             ),
//             // const SizedBox(
//             //   height: 5,
//             // ),
//             // FloatingActionButton(
//             //   backgroundColor: const Color(0xFF4A43EC),
//             //   onPressed: () {},
//             //   child: Column(
//             //     mainAxisAlignment: MainAxisAlignment.center,
//             //     children: [
//             //       const Icon(
//             //         Icons.swipe_up,
//             //         color: Colors.white,
//             //       ),
//             //       textwidget(
//             //         data: "SwipeUp",
//             //         fontSize: 10,
//             //         color: Colors.white,
//             //       )
//             //     ],
//             //   ),
//             // )
//           ],
//         ),
//       )
//     ],
//   );
// }

Text textwidget({
  required String data,
  Color? color,
  decorationColor,
  double? fontSize,
  FontWeight? fontWeight,
  TextDecoration? decoration,
}) {
  return Text(
    data,
    style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: decoration,
        decorationColor: decorationColor),
  );
}