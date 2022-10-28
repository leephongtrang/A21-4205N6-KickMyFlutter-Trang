import 'package:flutter/material.dart';
import 'package:tp_5n6/addTask.dart';
import 'package:tp_5n6/logIn.dart';
import 'package:tp_5n6/models/singleton.dart';
import 'package:tp_5n6/taskDetail.dart';
import 'package:tp_5n6/transfer.dart';
import 'package:intl/intl.dart';

import 'http_lib.dart';

class Main extends StatefulWidget{
  @override
  MainPage createState() => MainPage();
}

class MainPage extends State<Main>{
  late List<HomeItemResponse> taskList;

  void initState()  {
    /*taskList = [ Task('Anne', 463, 645, DateTime.utc(4524, 1, 1)),
      Task('Brigitte', 645, 4, DateTime.utc(9531, 1, 1)),
      Task('Charlotte', 245, 239, DateTime.utc(2123, 1, 1)),
      Task('Diane', 245, 46, DateTime.utc(1538, 1, 1))];*/
    taskList = [];
    _listItem();
  }

  Future<void> _listItem() async {
    List<HomeItemResponse> lt = await SingletonDio.home();
    taskList = lt;
    setState(() {});
  }

  String _username(){
    if(Singleton().getUsername() == null){
      return "sdad";
    }
    else { return Singleton().getUsername(); }
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
                subtitle: Text('Time pass: ${taskList[i].percentageTimeSpent}% | Final date : ${DateFormat('dd/MMM/yyyy').format(taskList[i].deadline)}'),
                trailing: Text('${taskList[i].percentageDone}%'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TaskDetail(id: taskList[i].id,)));
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Singleton().getUsername()'),
            ),
            ListTile(
              title: const Text('Add task'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddTask()));
              },
            ),
            ListTile(
              title: const Text('Log out'),
              onTap: () async {
                SingletonDio.signout();
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
              },
            ),
          ],
        ),
      ),
    );
  }
}