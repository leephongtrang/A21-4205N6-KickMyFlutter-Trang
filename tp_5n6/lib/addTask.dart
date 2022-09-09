import 'package:flutter/material.dart';

class AddTask extends StatefulWidget{
  @override
  AddTaskPage createState() => AddTaskPage();
}

class AddTaskPage extends State<AddTask>{
  late TextEditingController _controllerName;

  get onDateChanged => null;

  void initState(){
    _controllerName = TextEditingController();
  }

  @override
  Widget build(BuildContext buildContext){
    return Scaffold(
      appBar: AppBar(
        title: Text("New Task"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CalendarDatePicker(initialDate: DateTime.now(), firstDate: DateTime.utc(DateTime.now().year-1), lastDate: DateTime.utc(DateTime.now().year+50), onDateChanged: onDateChanged)
// https://pub.dev/packages/syncfusion_flutter_calendar/example

        ],
      ),
    );
  }
}