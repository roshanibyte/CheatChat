import 'dart:async';
import 'dart:developer';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:testapp/chat_page/view/kids_game/data.dart';

class GameViewPage extends StatefulWidget {
  final Level level;
  GameViewPage({required this.level});

  @override
  State<GameViewPage> createState() => _GameViewPageState(level);
}

class _GameViewPageState extends State<GameViewPage> {
  _GameViewPageState(this.level);
  int previousIndex = -1;
  bool flip = false;
  bool start = false;
  late Level level;
  bool wait = false;

  Timer? timer;
  int? time;
  int? left;
  bool isFinished = true;
  List<String>? _data;

  List<bool>? cardFlips;
  List<GlobalKey<FlipCardState>>? cardStateKeys;

  Widget getItem(int index) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[100],
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              offset: Offset(2, 1),
              spreadRadius: 0.8,
            )
          ],
          borderRadius: BorderRadius.circular(5)),
      child: Image.asset(_data![index]),
    );
  }

  void reStart() {
    startTimer();
    _data = getSourceArray(level);
    cardFlips = getInitialItemState(level);
    cardStateKeys = getCardStateKeys(level);
    time = 6;
    left = _data!.length ~/ 2;
    isFinished = false;
    Future.delayed(Duration(seconds: 6), () {
      setState(() {
        start = true;
        timer!.cancel();
      });
    });
  }

  startTimer() {
    timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        setState(() {
          time = time! - 1;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    reStart();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isFinished
        ? Scaffold(
            body: Stack(children: [
              Image.asset(
                "assets/zoo_animal.jpg",
                fit: BoxFit.cover,
                height: Get.height,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      reStart();
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset("assets/winner.json"),
                      5.verticalSpace,
                      Text(
                        "Winner",
                        style: TextStyle(
                            shadows: [
                              Shadow(
                                color: Colors.green,
                                blurRadius: 1,
                                offset: Offset(1, 1),
                              )
                            ],
                            color: Colors.pink.shade300,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w700),
                      ),
                      20.verticalSpace,
                      Container(
                        height: 50,
                        width: 200,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                offset: Offset(4, 6),
                                color: Colors.green,
                                spreadRadius: 1,
                              ),
                              BoxShadow(
                                blurRadius: 10,
                                offset: Offset(-0, -6),
                                color: Colors.green.shade100,
                                spreadRadius: 0.6,
                              ),
                            ],
                            color: Colors.pinkAccent.shade400,
                            borderRadius: BorderRadius.circular(25)),
                        child: Text(
                          "Replay",
                          style: TextStyle(
                              shadows: [
                                Shadow(
                                  color: Colors.red,
                                  blurRadius: 1,
                                  offset: Offset(1, 1),
                                )
                              ],
                              color: Colors.green,
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          )
        : Scaffold(
            body: Stack(children: [
              Image.asset(
                "assets/zoo_animal.jpg",
                fit: BoxFit.cover,
                height: Get.height,
              ),
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.sp),
                        child: time! > 0
                            ? Text(
                                "$time",
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              )
                            : Text(
                                "Left: $left",
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 7,
                                  mainAxisSpacing: 7,
                                  crossAxisCount: 3),
                          itemCount: _data!.length,
                          itemBuilder: (context, index) {
                            return start
                                ? FlipCard(
                                    key: cardStateKeys![index],
                                    onFlip: () {
                                      if (!flip) {
                                        flip = true;
                                        previousIndex = index;
                                      } else {
                                        flip = false;
                                        if (previousIndex != index) {
                                          if (_data![previousIndex] !=
                                              _data![index]) {
                                            wait = true;

                                            Future.delayed(
                                                const Duration(
                                                    milliseconds: 1500), () {
                                              cardStateKeys?[previousIndex]
                                                  .currentState
                                                  ?.toggleCard();
                                              previousIndex = index;
                                              cardStateKeys?[previousIndex]
                                                  .currentState
                                                  ?.toggleCard();

                                              Future.delayed(
                                                  const Duration(
                                                      milliseconds: 130), () {
                                                setState(() {
                                                  wait = false;
                                                });
                                              });
                                            });
                                          } else {
                                            cardFlips?[previousIndex] = false;
                                            cardFlips?[index] = false;
                                            print(cardFlips);

                                            setState(() {
                                              left = left! - 1;
                                            });
                                            if (cardFlips!
                                                .every((t) => t == false)) {
                                              log("error here");
                                              Future.delayed(
                                                  const Duration(
                                                      milliseconds: 160), () {
                                                setState(() {
                                                  log("Flipped and fnished false");
                                                  isFinished = true;
                                                  log("Flipped and fnished true");
                                                  start = false;
                                                });
                                              });
                                            }
                                          }
                                        }
                                      }
                                      setState(() {
                                        log("Flipped and fnished done");
                                      });
                                    },
                                    direction: FlipDirection.HORIZONTAL,
                                    flipOnTouch:
                                        wait ? false : cardFlips![index],
                                    front: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(4, 4),
                                            spreadRadius: 1,
                                            blurRadius: 4,
                                            color: Colors.black12,
                                          ),
                                          BoxShadow(
                                            offset: Offset(-4, -4),
                                            spreadRadius: 1,
                                            blurRadius: 4,
                                            color: Colors.black,
                                          ),
                                        ],
                                        color: Colors.white,
                                      ),
                                      margin: EdgeInsets.all(5.0),
                                      padding: EdgeInsets.all(15.sp),
                                      child: Image.asset(
                                        "assets/animals/quest.png",
                                      ),
                                    ),
                                    back: getItem(index))
                                : getItem(index);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ]),
          );
  }
}
