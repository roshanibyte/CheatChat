import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:testapp/data/data_base.dart';

class ToDoTask extends StatefulWidget {
  const ToDoTask({super.key});

  @override
  _ToDoTaskState createState() => _ToDoTaskState();
}

class _ToDoTaskState extends State<ToDoTask> {
  final _controller = TextEditingController();
  int selectedChipIndex = 0;

  final _mybox = Hive.box("myBox");

  ToDoDataBase db = ToDoDataBase();

  void onSave() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void onDelete(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  void initState() {
    //if this the first time page is loaading

    if (_mybox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadDataFromBox();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[300],
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        backgroundColor: Colors.green,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialogs(
              controller: _controller,
              onCancel: () {
                Navigator.of(context).pop();
              },
              onSave: () {
                onSave();
              },
            ),
          );
        },
      ),
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
          ('To Do Task').capitalize!.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            value: db.toDoList[index][1],
            onDeleteFuction: (context) {
              setState(() {
                onDelete(index);
              });
            },
            onChanged: (context) {
              setState(() {
                db.toDoList[index][1] = !db.toDoList[index][1];
              });
            },
          );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class AlertDialogs extends StatelessWidget {
  final controller;
  void Function()? onCancel;
  void Function()? onSave;
  AlertDialogs(
      {super.key,
      required this.controller,
      required this.onCancel,
      required this.onSave});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.green[300],
      content: Container(
        height: 120.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            10.verticalSpace,
            TextField(
              style: TextStyle(
                color: Colors.white,
              ),
              controller: controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Add New Task..",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  )),
            ),
            10.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  color: Colors.red,
                  onPressed: onCancel,
                  child: Text(
                    "Discard",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                10.horizontalSpace,
                MaterialButton(
                  color: Colors.green,
                  onPressed: onSave,
                  child: Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ToDoTile extends StatefulWidget {
  final String taskName;
  bool value;
  final void Function(bool?)? onChanged;
  void Function(BuildContext)? onDeleteFuction;

  ToDoTile({
    super.key,
    required this.taskName,
    required this.value,
    required this.onChanged,
    required this.onDeleteFuction,
  });
  @override
  State<ToDoTile> createState() => _ToDoTileState();
}

class _ToDoTileState extends State<ToDoTile> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: StretchMotion(), children: [
        SlidableAction(
          flex: 2,
          onPressed: widget.onDeleteFuction,
          backgroundColor: Colors.red,
          icon: Icons.delete,
        )
      ]),
      child: GestureDetector(
        onTap: () {
          setState(() {
            widget.value = !widget.value;
          });
        },
        child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.green,
          ),
          padding: EdgeInsets.all(15.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: widget.value,
                    onChanged: (value) {
                      setState(() {
                        widget.value = !widget.value;
                      });
                    },
                    checkColor: Colors.green,
                    side: BorderSide(color: Colors.white),
                    activeColor: Colors.yellow,
                  ),
                  Text(
                    widget.taskName.capitalize!.toUpperCase().toString(),
                    style: TextStyle(
                        fontSize: 17.sp,
                        color: Colors.white,
                        decoration:
                            widget.value ? TextDecoration.lineThrough : null),
                  ),
                ],
              ),
              Text(
                widget.value ? "Completed" : "Pending",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: widget.value ? Colors.yellow : Colors.grey[400],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
