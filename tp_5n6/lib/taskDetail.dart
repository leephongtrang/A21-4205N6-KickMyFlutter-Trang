import 'package:flutter/material.dart';
import 'package:tp_5n6/addTask.dart';
import 'package:tp_5n6/logIn.dart';
import 'package:tp_5n6/transfer.dart';

import 'http_lib.dart';
import 'main.dart';

class TaskDetail extends StatefulWidget{
  final int id;
  const TaskDetail({required this.id});
  @override
  TaskDetailPage createState() => TaskDetailPage();
}

class TaskDetailPage extends State<TaskDetail>{


  HomeItemResponse task = HomeItemResponse();


  _plusOneProgress(){
    setState(() {
      task.percentageDone++;
    });
  }

  _minusOneProgress(){
    setState(() {
      task.percentageDone--;
    });
  }

  @override
  Widget build(BuildContext buildContext){
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Detail"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,        
          children: [
            Text(task.name),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      _minusOneProgress();
                    },
                    icon: Icon(Icons.arrow_circle_left_rounded)
                ),
                Text('Avancement: ${task.percentageDone}%'),
                IconButton(
                    onPressed: () {
                      _plusOneProgress();
                    },
                    icon: Icon(Icons.arrow_circle_right_rounded)
                ),
              ],
            ),
            Text('Time pass: ${task.percentageTimeSpent}%'),
            TextButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Main()));
            },
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                primary: Colors.white,
              ),
              child: Text("Update progress"),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Main menu'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => Main()));
              },
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
              onTap: () {
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