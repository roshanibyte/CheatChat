import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:testapp/model.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsPAgeController extends GetxController {
  NewsModal? jsonlist;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  getData() async {
    isLoading.value = true;
    String url =
        "https://newsapi.org/v2/top-headlines?sources=google-news-in&apiKey=5c767a6470c24316a96126edec1aa726";
    try {
      final response = await get(
        Uri.parse(url),
      );
      log(response.body);

      if (response.statusCode == 200) {
        jsonlist = newsModalFromJson(response.body);
        log("$jsonlist");
      } else {
        log("${response.statusCode}");
      }
      log("$response");
    } catch (e) {
      log("catch is -- $e");
    }
    isLoading.value = false;
  }

  Future<void> launchUrls({required int index}) async {
    final Uri urls = Uri.parse(jsonlist?.articles[index].url.toString() ?? '');
    if (await canLaunchUrl(urls)) {
      log("This is the url = $urls");

      await launchUrl(
        urls,
        mode: LaunchMode.inAppBrowserView,
      );
    } else {
      throw Exception('Could not launch $urls');
    }
  }
}
