import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'main.dart';

class AddTask extends StatefulWidget{
  @override
  AddTaskPage createState() => AddTaskPage();
}

class AddTaskPage extends State<AddTask>{
  late TextEditingController _controllerTaskName;

  get onDateChanged => null;

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

          Text('Selected date: $_selectedDate'),//TODO A RETIRER
          Text('Selected date count: $_dateCount'),
          Text('Selected range: $_range'),
          Text('Selected ranges count: $_rangeCount'),

          SfDateRangePicker(
            onSelectionChanged: _onSelectionChanged,
            selectionMode: DateRangePickerSelectionMode.single,
            initialSelectedRange: PickerDateRange(
                DateTime.now().subtract(const Duration(days: 4)),
                DateTime.now().add(const Duration(days: 3))),
          ),

          TextButton(
            onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Main()));
          },
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              primary: Colors.white,
            ),
            child: Text("Add"),
          ),
        ],
      )
    );
  }
}