import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:testapp/auth/log_in_page/views/log_in_page.dart';
import 'package:testapp/landing_page/landing_page1.dart';
import 'package:testapp/landing_page/landing_page2.dart';
import 'package:testapp/landing_page/landing_page3.dart';

class LandingPage extends StatefulWidget {
  LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final PageController _pageController = PageController();
  bool onlastPage = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          onPageChanged: (index) {
            onlastPage = (index == 2);
            setState(() {});
          },
          controller: _pageController,
          children: [
            LandingPage1(),
            LandingPage2(),
            LandingPage3(),
          ],
        ),
        Container(
          alignment: Alignment(0, 0.75),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  _pageController.jumpToPage(2);
                },
                child: SizedBox(
                  height: 30.h,
                  child: Text(
                    "Skip",
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.yellow,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
              SmoothPageIndicator(
                controller: _pageController,
                count: 3,
                effect: SwapEffect(
                  dotColor: Colors.blue.shade100,
                  dotHeight: 12.h,
                  dotWidth: 12.w,
                  activeDotColor: Colors.blue,
                ),
              ),
              onlastPage
                  ? GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LogInPage(),
                          ),
                        );
                      },
                      child: SizedBox(
                        height: 30,
                        child: Text(
                          "Done",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.green,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.bounceIn,
                        );
                      },
                      child: SizedBox(
                        height: 30,
                        child: Text(
                          "Next",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                    )
            ],
          ),
        )
      ],
    );
  }
}
