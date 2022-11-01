import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:tp_5n6/transfer.dart';
import 'package:cookie_jar/cookie_jar.dart';

class SingletonDio {
  static var cookiemanager = CookieManager(CookieJar());

  static Dio getDio() {
    Dio dio = Dio();
    dio.interceptors.add(cookiemanager);
    return dio;
  }

  static String urlAndroid = "http://10.0.2.2:8080/";
  static String urliOS = "http://127.0.0.1:8080/";

  static Future<SigninResponse> signup(SignupRequest s) async {
    try {
      var response = await getDio().post(
          '${urlAndroid}api/id/signup',
          data: s//TODO flutter clean avant de remettre le TP
      );
      print(response);
      return SigninResponse.fromJson(response.data);
    }
    catch (e) {
      print(e);
      throw(e);
    }
  }

  static Future<SigninResponse> signin(SigninRequest s) async {
    try {
      var response = await getDio().post(
          '${urlAndroid}api/id/signin',//iOS 127.0.0.1:8080
          data: s
      );
      return  SigninResponse.fromJson(response.data);
    }
    catch (e) {
      print(e);
      throw(e);
    }
  }

  static Future<String> signout() async {
    try {
      var response = await getDio().post(
        '${urlAndroid}api/id/signout',//iOS 127.0.0.1:8080

      );
      print(response);
      return response.data;
    }
    catch (e) {
      print(e);
      throw(e);
    }
  }

  static Future<String> addTask(AddTaskRequest a) async {
    try {
      var response = await getDio().post(
          '${urlAndroid}api/add',//iOS 127.0.0.1:8080
          data: a
      );
      print(response);
      return  response.data;
    }
    catch (e) {
      print(e);
      throw(e);
    }
  }

  static Future<String> update(int id, int value) async {
    try {
      var response = await getDio().get(
        '${urlAndroid}api/progress/$id/$value',//iOS 127.0.0.1:8080
      );
      print(response);
      return response.data;
    }
    catch (e) {
      print(e);
      throw(e);
    }
  }

  static Future<List<HomeItemPhotoResponse>> home() async {
    try {
      var response = await getDio().get(
        '${urlAndroid}api/home/photo',
      );

      var listJSON = response.data as List;
      var listHomeItemResponse = listJSON.map(
              (e) {
            return HomeItemPhotoResponse.fromJson(e);
          }
      ).toList();
      print(response);
      return listHomeItemResponse;
    }
    catch (e) {
      print(e);
      throw(e);
    }
  }

  static Future<String> upload(File file, int id) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({"file": await MultipartFile.fromFile(file.path, filename: fileName), "taskID": id});

      var response = await getDio().post(
        '${urlAndroid}file',
        data:formData
      );
      print(response.data);
      return response.data;
    }
    catch(e) {
      throw(e);
    }
  }

  static Future<TaskDetailPhotoResponse> getDetailPhoto(int id) async {
    try {
      var response = await getDio().get('${urlAndroid}api/detail/photo/${id}');

      print(response.data);

      return TaskDetailPhotoResponse.fromJson(response.data);
    }
    catch (e) {
      throw(e);
    }
  }

}