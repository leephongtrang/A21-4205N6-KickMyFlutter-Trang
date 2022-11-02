import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tp_5n6/addTask.dart';
import 'package:tp_5n6/main.dart';
import 'package:tp_5n6/models/singleton.dart';
import 'package:tp_5n6/taskDetail.dart';
import 'package:tp_5n6/transfer.dart';
import 'package:intl/intl.dart';

import 'http_lib.dart';

class Main extends StatefulWidget{
  const Main({Key? key}) : super(key: key);

  @override
  MainPage createState() => MainPage();
}

class MainPage extends State<Main>{
  List<HomeItemPhotoResponse> taskList = [];
  String errorMessage = '';

  void initState() {
    EasyLoading.show(status: 'loading...');
    try {
      _listItem();
    }
    catch (e) {
      if (e is DioError) {
        if (e.response == null) {
          errorMessage = 'There is no connection';
        }
      }

      final snackBar = SnackBar(
        content: Text(errorMessage),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      EasyLoading.dismiss();
      throw(e);
    }
  }

  Future<void> _listItem() async {
    List<HomeItemPhotoResponse> lt = await SingletonDio.home();
    taskList = lt;
    setState(() {});
    EasyLoading.dismiss();
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
                leading: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    if (taskList[i].photoId != 0) {
                      return Image.network('${SingletonDio.urlAndroid}file/${taskList[i].photoId}?width=100');
                    }
                    else  {
                      return Text('');
                    }
                  },
                ),
                title: Text(taskList[i].name), //TODO mettre de l'imagination 🖼
                subtitle: Text('Time pass: ${taskList[i].percentageTimeSpent}% \nFinal date : ${DateFormat('dd/MMM/yyyy').format(taskList[i].deadline)}'),
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