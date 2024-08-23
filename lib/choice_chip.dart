import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChoiceChipExample extends StatefulWidget {
  const ChoiceChipExample({super.key});

  @override
  _ChoiceChipExampleState createState() => _ChoiceChipExampleState();
}

class _ChoiceChipExampleState extends State<ChoiceChipExample> {
  int selectedChipIndex = 0;
  List<Widget> mypages = <Widget>[
    // const Column(
    //   children: [Text("data"), Text("Name"), Text("Pictures")],
    // ),
    // const Column(
    //   children: [Text("Name"), Text("Najasdfjme"), Text("Picturesadad")],
    // ),
    // const Column(
    //   children: [Text("struc"), Text("Name"), Text("Pictures")],
    // ),
    const Text("You have selected Option 1"),
    const Text("You have selected Option 2"),
    const Text("You have selected Option 3")
    // const ChatPage(),
    // const StausPage(),
    // const NewsPage(),
  ];
  List<String> options = ['Option 1', 'Option 2', 'Option 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choice Chip Example'),
      ),
      body: Column(
        children: [
          Wrap(
            spacing: 8.0,
            children: List<Widget>.generate(options.length, (int index) {
              return ChoiceChip(
                label: Text(options[index]),
                selected: selectedChipIndex == index,
                selectedColor: Colors.green,
                onSelected: (bool selected) {
                  setState(() {
                    selectedChipIndex = selected ? index : -1;
                  });
                },
              );
            }),
          ),
          200.verticalSpace,
          Center(
            child: SizedBox(
              // width: double.infinity,
              // height: double.infinity,
              child: mypages[selectedChipIndex],
            ),
          )
        ],
      ),
    );
  }
}
