import 'dart:ffi';

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

  static String urlAndroid = "http://10.0.2.2:8080/api/";
  static String urliOS = "http://127.0.0.1:8080/api/";

  static Future<SigninResponse> signup(SignupRequest s) async {
    try {
      var response = await getDio().post(
          '${urlAndroid}id/signup',
          data: s//TODO flutter clean avant de remettre le TP
      );

      print(response.headers.map[1]);
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
          '${urlAndroid}id/signin',//iOS 127.0.0.1:8080
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
        '${urlAndroid}id/signout',//iOS 127.0.0.1:8080

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
          '${urlAndroid}add',//iOS 127.0.0.1:8080
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
        '${urlAndroid}progress/$id/$value',//iOS 127.0.0.1:8080
      );
      print(response);
      return response.data;
    }
    catch (e) {
      print(e);
      throw(e);
    }
  }

  static Future<List<HomeItemResponse>> home() async {
    try {
      var response = await getDio().get(
        '${urlAndroid}home',//iOS 127.0.0.1:8080
      );

      var listJSON = response.data as List;
      var listHomeItemResponse = listJSON.map(
              (e) {
            return HomeItemResponse.fromJson(e);
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

  static Future<TaskDetailResponse> detail(int id) async {
    try {
      var response = await getDio().get(
        '${urlAndroid}detail/$id'
      );
      print(response.data);

      return TaskDetailResponse.fromJson(response.data);
    }
    catch (e) {
      print(e);
      throw(e);
    }
  }
}



/*Future<String> cookieDemo() async {
  var response = await SingletonDio.getDio().get('http://exercices-web.herokuapp.com/exos/cookie/echo');
  print(response);
  return response.data;
}*/

