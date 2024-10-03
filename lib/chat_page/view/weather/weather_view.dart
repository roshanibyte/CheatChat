import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:testapp/chat_page/view/weather/weather_model.dart';
import 'package:testapp/chat_page/view/weather/weather_services.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  final weatherService = services(ApiKey: "a67d541e53a69ebb46b4c3f392011af1");
  weatherModel? _weather;
  //Fetch weather
  Future<void> fetchWeather() async {
    String cityName = await weatherService.getCurrentCity();
    try {
      final weather = await weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    fetchWeather();
    super.initState();
  }

  String getWeatherImages(String mainCondition) {
    switch (mainCondition.toLowerCase()) {
      case "cloud":
      case "mist":
      case "smoke":
      case "haze":
      case "dust":
      case "fog":
        return "assets/clouddy.png";
      case "thunderstorm":
        return "assets/thunder.png";
      case "rain":
      case "drizzle":
        return "assets/rainny.png";

      default:
        return "assets/sunny.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[300],
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        toolbarHeight: 65.h,
        leadingWidth: 30.w,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          ('Weather Today\'s '),
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: fetchWeather,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                100.verticalSpace,
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        style: TextStyle(),
                        text: "Temperature in ",
                      ),
                      TextSpan(
                        style: TextStyle(
                          fontSize: 25.sp,
                          color: Colors.yellow,
                        ),
                        text: "${_weather?.cityName ?? "Loading..."}",
                      ),
                    ],
                  ),
                ),
                Text(
                  "\n${_weather?.temperature.round() ?? "Loading..."} \u00B0C",
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.yellow[500],
                  ),
                ),
                Image.asset(
                  getWeatherImages(_weather?.mainCondition ?? ""),
                  height: 40.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
