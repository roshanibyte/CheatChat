import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:testapp/chat_page/view/kids_game/data.dart';
import 'package:testapp/chat_page/view/kids_game/game_view.dart';

class GameHomePage extends StatefulWidget {
  const GameHomePage({super.key});

  @override
  State<GameHomePage> createState() => _GameHomePageState();
}

class _GameHomePageState extends State<GameHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue,
      body: Stack(
        children: [
          Image.asset(
            "assets/game_background 2.jpg",
            height: Get.height,
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              AppBar(
        toolbarHeight: 65.h,

                elevation: 0,
                centerTitle: true,
                backgroundColor: Colors.transparent,
                leading: CupertinoButton(
                  child: Icon(
                    Icons.arrow_back,
                    size: 30.sp,
                    color: Colors.green,
                    shadows: [
                      Shadow(
                        color: Colors.red,
                        blurRadius: 2,
                        offset: Offset(2, 1),
                      )
                    ],
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
                title: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Memory",
                        style: TextStyle(
                            shadows: [
                              Shadow(
                                color: Colors.green,
                                blurRadius: 1,
                                offset: Offset(1, 1),
                              )
                            ],
                            color: Colors.red,
                            fontSize: 30.sp,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        text: " Enhancer",
                        style: TextStyle(
                            shadows: [
                              Shadow(
                                color: Colors.red,
                                blurRadius: 1,
                                offset: Offset(1, 1),
                              )
                            ],
                            color: Colors.green,
                            fontStyle: FontStyle.italic,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.8,
                width: Get.width,
                child: ListView.builder(
                  itemCount: _list.length,
                  itemBuilder: (context, index) {
                    return CupertinoButton(
                      pressedOpacity: 0.2,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => _list[index].goto),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 5.h,
                          horizontal: 20.w,
                        ),
                        child: Stack(
                          children: [
                            Transform(
                              transform: Matrix4.identity()
                                ..setEntry(2, 1, 0.001)
                                ..rotateX(0.3),
                              child: Container(
                                height: 100.h,
                                width: Get.width,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 10,
                                      offset: Offset(6, 6),
                                      color: Colors.black54,
                                      spreadRadius: 1,
                                    ),
                                    BoxShadow(
                                      blurRadius: 10,
                                      offset: Offset(-6, -6),
                                      color: Colors.black,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(24.r),
                                  color: _list[index].primerycolor,
                                ),
                              ),
                            ),
                            Transform(
                              transform: Matrix4.identity()
                                ..setEntry(2, 3, 0.001)
                                ..rotateX(0.4),
                              child: Container(
                                height: 90.h,
                                width: Get.width,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: _list[index].secondarycolor,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _list[index].name,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children:
                                          generateStar(_list[index].noOfStar),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

List<Widget> generateStar(int no) {
  List<Widget> _icons = [];
  for (int i = 0; i < no; i++) {
    _icons.insert(
      i,
      Icon(
        Icons.star,
        color: Colors.yellow,
      ),
    );
  }
  return _icons;
}

class Details {
  String name;
  Color? primerycolor;
  Color? secondarycolor;

  Widget goto;
  int noOfStar;
  Details({
    required this.name,
    this.primerycolor,
    this.noOfStar = 0,
    this.secondarycolor,
    required this.goto,
  });
}

List<Details> _list = [
  Details(
      name: "Easy",
      primerycolor: Colors.green,
      secondarycolor: Colors.green[200],
      noOfStar: 2,
      goto: GameViewPage(
        level: Level.Easy,
      )),
  Details(
    name: "Medium",
    primerycolor: Colors.orange,
    secondarycolor: Colors.orange[200],
    noOfStar: 3,
    goto: GameViewPage(
      level: Level.Medium,
    ),
  ),
  Details(
      name: "Hard",
      primerycolor: Colors.red,
      secondarycolor: Colors.red[200],
      noOfStar: 4,
      goto: GameViewPage(
        level: Level.Hard,
      )),
];
