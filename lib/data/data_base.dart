import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ToDoDataBase{
  List toDoList=[];
  final _mybox= Hive.box("myBox");

  void createInitialData(){
    toDoList = [
    ["Make Coffee", true],
    ["Go to the Excercise", false]
  ];
  }

  // load the data
  void loadDataFromBox(){
    toDoList= _mybox.get('TODOLIST');
  }

  //Update the data Base
  void updateDataBase(){
 _mybox.put("TODOLIST", toDoList);
  }
}