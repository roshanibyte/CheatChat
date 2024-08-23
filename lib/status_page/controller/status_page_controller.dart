import 'dart:developer';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/model.dart';

class StatusPageController extends GetxController{
CarouselController buttonCarouselController = CarouselController();
  ScrollController sController = ScrollController();
  int value = 1;
  int currentPage = 0;
  NewsModal? jsonlist;
  @override
  
    @override
  void onInit() {
    super.onInit();
    getNews();
  }

  Future<void> getNews() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=98ef0612a9ee40048f9b6e5b574e6e7c";

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
  }
}