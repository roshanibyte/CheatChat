import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ChatPageController extends GetxController {
  RxBool isLoading = false.obs;

  var jsonList;
  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData() async {
    log("ApI called");
    isLoading.value = true;
    try {
      String url = 'https://protocoderspoint.com/jsondata/superheros.json';
      final response = await Dio().get(url);
      log("resonse ${response.statusCode}");
      isLoading.value = false;
      log("is loading ${isLoading.value}");
      if (response.statusCode == 200) {
        jsonList = response.data['superheros'] as List;
      } else {
        log("${response.statusCode}");
      }
    } catch (e) {
      isLoading.value = false;

      log("$e");
    }
  }
}
