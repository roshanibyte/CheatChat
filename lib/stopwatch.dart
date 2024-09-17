import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StopWatchPage extends StatefulWidget {
  const StopWatchPage({super.key});

  @override
  State<StopWatchPage> createState() => _StopWatchPageState();
}

class _StopWatchPageState extends State<StopWatchPage> {
  late Stopwatch stopwatch;
  late Timer t;

  void handleStartStop() {
    if (stopwatch.isRunning) {
      stopwatch.stop();
    } else {
      stopwatch.start();
    }
  }

  String returnFormattedText() {
    var milli = stopwatch.elapsed.inMilliseconds;

    String milliseconds = (milli % 1000)
        .toString()
        .padLeft(3, "0"); // this one for the miliseconds
    String seconds = ((milli ~/ 1000) % 60)
        .toString()
        .padLeft(2, "0"); // this is for the second
    String minutes = ((milli ~/ 1000) ~/ 60)
        .toString()
        .padLeft(2, "0"); // this is for the minute

    return "$minutes:$seconds:$milliseconds";
  }

  @override
  void initState() {
    super.initState();
    stopwatch = Stopwatch();

    t = Timer.periodic(Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "data",
      //     style: TextStyle(color: Colors.amberAccent),
      //   ),
      // ),
      body: SafeArea(
        child: Center(
          child: Column(
            // this is the column
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoButton(
                onPressed: () {
                  handleStartStop();
                },
                padding: EdgeInsets.all(0),
                child: Container(
                  height: 250,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape
                        .circle,  
                    border: Border.all(
                      color: Color(0xff0395eb),
                      width: 4,
                    ),
                  ),
                  child: Text(
                    returnFormattedText(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoButton(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.red,
                    // this the cupertino button and here we perform all the reset button function
                    onPressed: () {
                      if (stopwatch.isRunning) {
                        null;
                      } else {
                        stopwatch.start();
                      }
                    },
                    padding: EdgeInsets.all(0),
                    child: Icon(
                      Icons.play_arrow,
                      size: 40,
                    ),
                  ),
                  10.horizontalSpace,
                  CupertinoButton(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.red,
                    // this the cupertino button and here we perform all the reset button function
                    onPressed: () {
                      if (stopwatch.isRunning) {
                        stopwatch.stop();
                      }
                    },
                    padding: EdgeInsets.all(0),
                    child: Icon(
                      Icons.pause,
                      size: 40,
                    ),
                  ),
                  10.horizontalSpace,
                  CupertinoButton(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.red,
                    // this the cupertino button and here we perform all the reset button function
                    onPressed: () {
                      stopwatch.reset();
                    },
                    padding: EdgeInsets.all(0),
                    child: Icon(
                      Icons.lock_reset,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
