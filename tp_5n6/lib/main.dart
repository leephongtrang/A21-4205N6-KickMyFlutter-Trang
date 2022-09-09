import 'package:flutter/material.dart';
import 'package:tp_5n6/addTask.dart';
import 'package:tp_5n6/taskDetail.dart';

class Main extends StatefulWidget{
  @override
  MainPage createState() => MainPage();
}

class MainPage extends State<Main>{
  late List<String> taskList;

  void initState(){
    taskList = ['Anne', 'Brigitte', 'Charlotte', 'Diane'];
  }

  @override
  Widget build(BuildContext buildContext){
    return Scaffold(
      appBar: AppBar(
        title: Text("Main"),
      ),
      body: ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (context, i){
          return Container(
            child: ListTile(
              title: Text(taskList[i].toString()), //TODO mettre de l'imagination 🖼
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TaskDetail()));
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddTask()));
        },
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}