import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tp_5n6/addTask.dart';
import 'package:tp_5n6/main.dart';
import 'package:tp_5n6/transfer.dart';
import 'package:intl/intl.dart';

import 'http_lib.dart';
import 'home.dart';

class TaskDetail extends StatefulWidget{
  final int id;
  const TaskDetail({required this.id});
  @override
  TaskDetailPage createState() => TaskDetailPage();
}

class TaskDetailPage extends State<TaskDetail>{
  TaskDetailPhotoResponse task = TaskDetailPhotoResponse();
  ImagePicker picker = ImagePicker();
  late File _imageFile;
  String imagePAth = '';
  String errorMessage = '';

  void initState() {
    EasyLoading.show(status: 'loading...');
    try {
      _getDetail(widget.id);
    }
    catch(e) {
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

  validation() {
    if (task.percentageDone > 100) {
      throw 'The advancement can not be over 100';
    }
    if (task.percentageDone < 0) {
      throw 'The advancement con not be under 0';
    }
  }

  Future<void> _getDetail(int id) async {
    task = await SingletonDio.getDetailPhoto(id);
    setState(() {});
    EasyLoading.dismiss();
  }

  Future<void> _update() async {
    if(imagePAth != ""){
      var response = await SingletonDio.upload(_imageFile, task.id);
    }
    var response = await SingletonDio.update(task.id, task.percentageDone);
  }

  Future _getImageGallery() async {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
    this.imagePAth = pickedFile!.path;
    _imageFile = File(imagePAth);
    setState(() {});
  }

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
            Text('Deadline : ${DateFormat('dd/MMM/yyyy').format(task.deadline)}'),
            TextButton(onPressed: () async {
              try {
                validation();
                await _update();
                Navigator.push(context, MaterialPageRoute(builder: (context) => Main()));
              }
              catch(e) {
                if (e is DioError) {
                  if (e.response == null) {
                    errorMessage = 'There is no connection';
                  }
                }
                if (e == 'The advancement can not be over 100') {
                  errorMessage = 'The advancement can not be over 100';
                }
                if (e == 'The advancement con not be under 0') {
                  errorMessage = 'The advancement con not be under 0';
                }

                final snackBar = SnackBar(
                  content: Text(errorMessage),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                throw(e);
              }
            },
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                primary: Colors.white,
              ),
              child: Text("Update progress"),
            ),
            GestureDetector(
              onTap: () async {
                await _getImageGallery();
              },
              child: Container(
                width: 100,
                height: 100,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    if (imagePAth != "") {
                      return Image(image: (imagePAth=="")?FileImage(File("")):FileImage(_imageFile));
                    }
                    else if (task.photoId != 0) {
                      return Image.network('${SingletonDio.urlAndroid}file/${task.photoId}');
                    }
                    return Text('');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _getImageGallery();
        },
        tooltip: 'Add Picture',
        child: const Icon(Icons.image),
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