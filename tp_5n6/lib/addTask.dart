import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:tp_5n6/main.dart';
import 'package:tp_5n6/models/singleton.dart';
import 'package:tp_5n6/transfer.dart';

import 'http_lib.dart';
import 'home.dart';

class AddTask extends StatefulWidget{
  @override
  AddTaskPage createState() => AddTaskPage();
}

class AddTaskPage extends State<AddTask>{
  late TextEditingController _controllerTaskName;

  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
        // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  void initState(){
    _controllerTaskName = TextEditingController();
  }

  Future<void> _addTaskRequest() async {
    AddTaskRequest a = new AddTaskRequest();
    a.deadline = DateTime.parse(_selectedDate);
    a.name = _controllerTaskName.text;
    try {
      await SingletonDio.addTask(a);
    }
    catch (e) {
      throw(e);
    }
  }

  @override
  Widget build(BuildContext buildContext){
    return Scaffold(
      appBar: AppBar(
        title: Text("New Task"),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: _controllerTaskName,
          ),

          SfDateRangePicker(
            onSelectionChanged: _onSelectionChanged,
            selectionMode: DateRangePickerSelectionMode.single,
            initialSelectedRange: PickerDateRange(
                DateTime.now().subtract(const Duration(days: 4)),
                DateTime.now().add(const Duration(days: 3))),
          ),

          TextButton(
            onPressed: () async {
            await _addTaskRequest();
            Navigator.push(context, MaterialPageRoute(builder: (context) => Main()));
          },
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              primary: Colors.white,
            ),
            child: Text("Add"),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('534fsdf'),
            ),
            ListTile(
              title: const Text('Main menu'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => Main()));
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