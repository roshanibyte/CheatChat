import 'dart:developer';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:testapp/model.dart';

class StatusPageController extends GetxController {
  CarouselController buttonCarouselController = CarouselController();
  // ScrollController sController = ScrollController();
  int value = 1;
  int currentPage = 0;
  RxBool isLoading = true.obs;
  // static List<String> yourStory=["https://thewaywomenwork.com/wp-content/uploads/2014/07/safety-in-india-www.png"];
  List status = [
    "https://indiatechnologynews.in/wp-content/uploads/2022/04/gaytri.jpg",
    "https://adpp.in/wp-content/uploads/2021/08/ADPPI-Profesional-Peers-www.adpp_.in_-scaled.jpg",
    "https://thewaywomenwork.com/wp-content/uploads/2014/07/safety-in-india-www.png",
    "https://indiatechnologynews.in/wp-content/uploads/2022/04/gaytri.jpg",
    "https://adpp.in/wp-content/uploads/2021/08/ADPPI-Profesional-Peers-www.adpp_.in_-scaled.jpg",
    "https://thewaywomenwork.com/wp-content/uploads/2014/07/safety-in-india-www.png",
  ];
  NewsModal? jsonlist;

  Future<void> getNews() async {
    isLoading.value = true;
    String url =
        "https://newsapi.org/v2/top-headlines?sources=google-news-in&apiKey=5c767a6470c24316a96126edec1aa726";

    // log("name ${jsonDecode(jsonDecode(jsonEncode(name)))}");

    try {
      final response = await Dio().get(url);
      // final response = await get(Uri.parse(url));
      log("message");
      if (response.statusCode == 200) {
        jsonlist = NewsModal.fromJson(response.data);

        log("List length ${jsonlist!.articles.length}");
      } else {
        log("no news= ${response.statusCode}");
      }
    } catch (e) {
      log("Exception here = $e");
    }
    isLoading.value = false;
  }
}
