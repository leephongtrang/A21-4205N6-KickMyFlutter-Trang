import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
  String errorMessage = '';

  void initState() {
    _controllerPassword1 = TextEditingController();
    _controllerUsername = TextEditingController();
    _controllerPassword2 = TextEditingController();
  }

  void validation() {
    String u = _controllerUsername.text;
    String p = _controllerPassword1.text;
    String cp = _controllerPassword2.text;
    if (u.isEmpty && p.isEmpty && cp.isEmpty) {
      throw 'Some field are empty.';
    }
    if (u.isEmpty) {
      throw 'Username field is empty.';
    }
    if (p.isEmpty) {
      throw 'Password field is empty.';
    }
    if (cp.isEmpty) {
      throw 'Please confirm your password.';
    }
    if (p != cp) {
      throw 'The Passwords are different.';
    }
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
            FocusManager.instance.primaryFocus?.unfocus();
            EasyLoading.show(status: 'loading...');
            try {
              validation();
              await _signup(_controllerUsername.text, _controllerPassword1.text);
              Navigator.push(context, MaterialPageRoute(builder: (context) => Main()));
              EasyLoading.dismiss();
            }
            catch (e) {
              if (e is DioError) {
                if (e.response?.data == 'UsernameTooShort') {
                  errorMessage = 'Username is too short.';
                }
                if (e.response?.data == 'PasswordTooShort') {
                  errorMessage = 'Password is too short.';
                }
                if (e.response?.data == 'UsernameAlreadyTaken') {
                  errorMessage = 'Username is already taken.';
                }
                if (e.response == null) {
                  errorMessage = 'There is no connection.';
                }
              }
              if (e == 'Some field are empty.') {
                errorMessage = 'Some field are empty.';
              }
              if (e == 'Username field is empty.') {
                errorMessage = 'Username field is empty.';
              }
              if (e == 'Password field is empty') {
                errorMessage = 'Password field is empty.';
              }
              if (e == 'Please confirm your password.') {
                errorMessage = 'Please confirm your password.';
              }
              if (e == 'The Passwords are different.') {
                errorMessage = 'The Passwords are different.';
              }
              final snackBar = SnackBar(
                content: Text(errorMessage),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              EasyLoading.dismiss();
              throw(e);
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