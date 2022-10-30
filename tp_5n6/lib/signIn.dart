import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tp_5n6/http_lib.dart';
import 'package:tp_5n6/home.dart';
import 'package:tp_5n6/transfer.dart';

import 'models/singleton.dart';

class SignIn extends StatefulWidget{
  const SignIn();
  @override
  SignInPage createState() => SignInPage();
}

class SignInPage extends State<SignIn> {
  late TextEditingController _controllerUsername;
  late TextEditingController _controllerPassword1;
  late TextEditingController _controllerPassword2;

  void initState() {
    _controllerPassword1 = TextEditingController();
    _controllerUsername = TextEditingController();
    _controllerPassword2 = TextEditingController();
  }

  Future<void> _signup(String username, String password) async {
    SignupRequest s = SignupRequest();
    s.username = username;
    s.password = password;
    try {
      SigninResponse signinResponse = await SingletonDio.signup(s);
    }
    catch(e){
      print(e);
      throw(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _controllerUsername,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Username",
            ),
          ),
          TextField(
            obscureText: true,
            controller: _controllerPassword1,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Password",
            ),
          ),
          TextField(
            obscureText: true,
            controller: _controllerPassword2,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Confirm password",
            ),
          ),
          TextButton(onPressed: () async {
            try {
              await _signup(_controllerUsername.text, _controllerPassword1.text);
              Navigator.push(context, MaterialPageRoute(builder: (context) => Main()));
            } on DioError catch (e) {

            }
          },
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              primary: Colors.white,
            ),
            child: Text("Sign In"),
          ),
        ],
      ),
    );
  }
}