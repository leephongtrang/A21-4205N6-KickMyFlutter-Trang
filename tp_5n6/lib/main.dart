import 'package:flutter/material.dart';
import 'package:tp_5n6/addTask.dart';
import 'package:tp_5n6/taskDetail.dart';
import 'package:intl/intl.dart';

import 'models/task.dart';

class Main extends StatefulWidget{
  @override
  MainPage createState() => MainPage();
}

class MainPage extends State<Main>{
  late List<Task> taskList;

  void initState(){
    taskList = [ Task('Anne', 463, 645, DateTime.utc(4524, 1, 1)),
      Task('Brigitte', 645, 4, DateTime.utc(9531, 1, 1)),
      Task('Charlotte', 245, 239, DateTime.utc(2123, 1, 1)),
      Task('Diane', 245, 46, DateTime.utc(1538, 1, 1))];
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
            child: Card(
              child: ListTile(
                title: Text(taskList[i].name), //TODO mettre de l'imagination 🖼
                subtitle: Text('Time pass: ${taskList[i].timeProgressPercent}% | Final date : ${DateFormat('dd/MMM/yyyy').format(taskList[i].end)}'),
                trailing: Text('${taskList[i].progressPercent}%'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TaskDetail(task: taskList[i])));
                },
              ),
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