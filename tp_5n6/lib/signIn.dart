import 'package:flutter/material.dart';
import 'package:tp_5n6/main.dart';
import 'package:dio/dio.dart';

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

  void _signup(String username, String password) async {
    try {

    } catch(e){

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
          TextButton(onPressed: () {

            Navigator.push(context, MaterialPageRoute(builder: (context) => Main()));
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