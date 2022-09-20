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
}

Future<String> cookieDemo() async {
  var response = await SingletonDio.getDio().get('http://exercices-web.herokuapp.com/exos/cookie/echo');
  print(response);
  return response.data;
}

Future<SigninResponse> signup(SignupRequest s) async {
  try {
    var response = await Dio().post(
        'http://10.0.2.2:8080/api/id/signup',//iOS 127.0.0.1:8080
        //TODO flutter clean avant de remettre le TP
        data: s
    );
    print(response);
    return  SigninResponse.fromJson(response.data);
  }
  catch (e) {
    print(e);
    throw(e);
  }
}

Future<SigninResponse> signin(SigninRequest s) async {
  try {
    var response = await Dio().post(
        'http://10.0.2.2:8080/api/id/signin',//iOS 127.0.0.1:8080
        data: s
    );
    print(response);
    return  SigninResponse.fromJson(response.data);
  }
  catch (e) {
    print(e);
    throw(e);
  }
}

Future<String> signout() async {
  try {
    var response = await Dio().post(
        'http://10.0.2.2:8080/api/id/signout',//iOS 127.0.0.1:8080

    );
    print(response);
    return response.data;
  }
  catch (e) {
    print(e);
    throw(e);
  }
}

Future<String> addTask(AddTaskRequest a) async {
  try {
    var response = await Dio().post(
        'http://10.0.2.2:8080/api/add',//iOS 127.0.0.1:8080
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
