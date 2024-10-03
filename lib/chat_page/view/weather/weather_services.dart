import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:testapp/chat_page/view/weather/weather_model.dart';

class services {
  static const Base_Url = "https://api.openweathermap.org/data/2.5/weather";
  final String ApiKey;

  services({required this.ApiKey});

  Future<weatherModel> getWeather(String cityName) async {
    final response = await get(
        Uri.parse("$Base_Url?q=$cityName&appid=$ApiKey&units=metric"));
    if (response.statusCode == 200) {
      return weatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placeMark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    String? city = placeMark[0].locality;
    return city ?? "";
  }
}
