import 'package:flutter/material.dart';
import 'package:tp_5n6/models/task.dart';

class TaskDetail extends StatefulWidget{
  final Task task;
  const TaskDetail({required this.task});
  @override
  TaskDetailPage createState() => TaskDetailPage();
}

class TaskDetailPage extends State<TaskDetail>{
  _plusOneProgress(){
    setState(() {
      widget.task.progressPercent++;
    });
  }

  _minusOneProgress(){
    setState(() {
      widget.task.progressPercent--;
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
            Text(widget.task.name),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      _minusOneProgress();
                    },
                    icon: Icon(Icons.arrow_circle_left_rounded)
                ),
                Text('Avancement: ${widget.task.progressPercent}%'),
                IconButton(
                    onPressed: () {
                      _plusOneProgress();
                    },
                    icon: Icon(Icons.arrow_circle_right_rounded)
                ),
              ],
            ),
            Text('Time pass: ${widget.task.timeProgressPercent}%')
          ],
        ),
      ),
    );
  }
}