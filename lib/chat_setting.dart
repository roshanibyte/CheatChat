import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DismissedItem extends StatefulWidget {
  const DismissedItem({super.key});

  @override
  State<DismissedItem> createState() => _DismissedState();
}

class _DismissedState extends State<DismissedItem> {
  List<String> items = List.generate(5, (index) => 'Item ${index + 1}');
  Color _backgroundColor = Colors.blue; // Initial background color

  void _changeColorOnSwipe(DragUpdateDetails details) {
    if (details.delta.dx > 0) {
      // Swipe right
      setState(() {
        _backgroundColor = Colors.green;
      });
    } else if (details.delta.dx < 0) {
      // Swipe left
      setState(() {
        _backgroundColor = Colors.red;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        backgroundColor: Colors.grey.withOpacity(0.6),
        title: const Text('Dismissible Example'),
        actions: [
          GestureDetector(
              onTap: () {
                setState(() {
                  // colorChange = !colorChange;
                });
              },
              child: const Icon(Icons.color_lens)),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: Get.height * 0.4,
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Dismissible(
                  key: Key(
                    item,
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      items.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$item dismissed'),
                      ),
                    );
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(
                      right: 20,
                    ),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      item,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          GestureDetector(
            onDoubleTap: () {
              setState(() {});
              _backgroundColor = Colors.blue;
            },
            onHorizontalDragUpdate: _changeColorOnSwipe,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(21),
                color: _backgroundColor,
              ),
              // Use the current background color
              child: const Center(
                child: Text(
                  'Swipe me!',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';

class CricketPitch extends StatefulWidget {
  const CricketPitch({super.key});

  @override
  State<CricketPitch> createState() => _CricketPitchState();
}

class _CricketPitchState extends State<CricketPitch> {
  bool run = true;
  bool palceField = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 65.h,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Play Cricket',
          style: TextStyle(color: Colors.grey),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: Container(
              height: 410,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                color: Colors.green,
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 40,
                    child: Container(
                      height: 420,
                      width: 35,
                      color: Colors.green.shade800,
                    ),
                  ),

                  Positioned(
                    top: 10,
                    child: Container(
                      height: 35,
                      width: 300,
                      color: Colors.green.shade800,
                    ),
                  ),
                  Positioned(
                    left: 100,
                    child: Container(
                      height: 420,
                      width: 35,
                      color: Colors.green.shade800,
                    ),
                  ),
                  Positioned(
                    top: 70,
                    child: Container(
                      height: 35,
                      width: 400,
                      color: Colors.green.shade800,
                    ),
                  ),
                  Positioned(
                    left: 210,
                    child: Container(
                      height: 420,
                      width: 40,
                      color: Colors.green.shade800,
                    ),
                  ),
                  Positioned(
                    top: 130,
                    child: Container(
                      height: 35,
                      width: 400,
                      color: Colors.green.shade800,
                    ),
                  ),
                  Positioned(
                    left: 270,
                    child: Container(
                      height: 420,
                      width: 40,
                      color: Colors.green.shade800,
                    ),
                  ),
                  Positioned(
                    left: 150,
                    child: Container(
                      height: 420,
                      width: 40,
                      color: Colors.green.shade800,
                    ),
                  ),
                  Positioned(
                    top: 190,
                    child: Container(
                      height: 35,
                      width: 400,
                      color: Colors.green.shade800,
                    ),
                  ),
                  Positioned(
                    top: 250,
                    child: Container(
                      height: 35,
                      width: 400,
                      color: Colors.green.shade800,
                    ),
                  ),
                  Positioned(
                    top: 310,
                    child: Container(
                      height: 35,
                      width: 400,
                      color: Colors.green.shade800,
                    ),
                  ),
                  Positioned(
                    top: 360,
                    child: Container(
                      height: 35,
                      width: 400,
                      color: Colors.green.shade800,
                    ),
                  ),
                  Positioned(
                    top: 130,
                    left: 150,
                    // right: 50,
                    child: Container(
                      height: 150,
                      width: 50,
                      color: Colors.brown,
                    ),
                  ),
                  // Players indicated as dots

                  AnimatedPositioned(
                      top: palceField == false ? 250 : 100,
                      left: palceField == false ? 0 : 165,
                      duration: const Duration(seconds: 1),
                      child: const Fielder()),
                  AnimatedPositioned(
                      top: palceField == false ? 250 : 90,
                      left: palceField == false ? 0 : 200,
                      duration: const Duration(seconds: 1),
                      child: const Fielder()),
                  AnimatedPositioned(
                      top: palceField == false ? 250 : 90,
                      left: palceField == false ? 0 : 130,
                      duration: const Duration(seconds: 1),
                      child: const Fielder()),
                  AnimatedPositioned(
                      top: palceField == false ? 250 : 100,
                      left: palceField == false ? 0 : 30,
                      duration: const Duration(seconds: 1),
                      child: const Fielder()),
                  AnimatedPositioned(
                      top: palceField == false ? 250 : 360,
                      left: palceField == false ? 0 : 100,
                      duration: const Duration(seconds: 1),
                      child: const Fielder()),
                  AnimatedPositioned(
                      top: palceField == false ? 250 : 360,
                      left: palceField == false ? 0 : 250,
                      duration: const Duration(seconds: 1),
                      child: const Fielder()),
                  AnimatedPositioned(
                      top: palceField == false ? 250 : 200,
                      left: palceField == false ? 0 : 100,
                      duration: const Duration(seconds: 1),
                      child: const Fielder()),
                  AnimatedPositioned(
                      top: palceField == false ? 250 : 250,
                      left: palceField == false ? 0 : 250,
                      duration: const Duration(seconds: 1),
                      child: const Fielder()),
                  AnimatedPositioned(
                      top: palceField == false ? 250 : 200,
                      left: palceField == false ? 0 : 330,
                      duration: const Duration(seconds: 1),
                      child: const Fielder()),
                  AnimatedPositioned(
                      top: palceField == false ? 250 : 30,
                      left: palceField == false ? 0 : 100,
                      duration: const Duration(seconds: 1),
                      child: const Fielder()),
                  AnimatedPositioned(
                      top: palceField == false ? 250 : 30,
                      left: palceField == false ? 0 : 250,
                      duration: const Duration(seconds: 1),
                      child: const Fielder()),

                  AnimatedPositioned(
                      top: palceField == false ? 250 : 290,
                      left: palceField == false ? 0 : 165,
                      duration: const Duration(seconds: 1),
                      child: const SizedBox(
                        width: 10,
                        height: 10,
                        child: Icon(
                          Icons.person_2_rounded,
                        ),
                      )),
                  Positioned(
                    bottom: 55,
                    left: 30,
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 150,
                    left: 150,
                    child: Container(
                      width: 50,
                      height: 2,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    bottom: 147,
                    left: 150,
                    child: Container(
                      width: 50,
                      height: 2,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    top: 130,
                    left: 170,
                    child: Container(
                      width: 3,
                      height: 2,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    top: 130,
                    left: 175,
                    child: Container(
                      width: 3,
                      height: 2,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    top: 130,
                    left: 180,
                    child: Container(
                      width: 3,
                      height: 2,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    bottom: 125,
                    left: 170,
                    child: Container(
                      width: 3,
                      height: 2,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    bottom: 125,
                    left: 175,
                    child: Container(
                      width: 3,
                      height: 2,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    bottom: 125,
                    left: 180,
                    child: Container(
                      width: 3,
                      height: 2,
                      color: Colors.white,
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(seconds: 1),
                    bottom: run == true ? 140 : 270,
                    right: run == true ? 200 : 165,
                    child: const SizedBox(
                      width: 10,
                      height: 10,
                      // decoration: const BoxDecoration(
                      //   shape: BoxShape.circle,
                      //   color: Colors.red,
                      // ),
                      child: Icon(
                        Icons.person,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(seconds: 1),
                    bottom: run == false ? 140 : 270,
                    right: run == false ? 200 : 165,
                    child: const SizedBox(
                      width: 10,
                      height: 10,
                      child: Icon(
                        Icons.person,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      palceField = !palceField;
                    });
                  },
                  child: const Icon(Icons.sports_cricket)),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      run = !run;
                    });
                  },
                  child: const Icon(Icons.play_arrow)),
            ],
          )
        ],
      ),
    );
  }
}

class Fielder extends StatelessWidget {
  const Fielder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 10,
      height: 10,
      child: Icon(
        Icons.person,
        color: Colors.blue,
      ),
    );
  }
}
