import 'package:flutter/material.dart';
import 'package:tp_5n6/http_lib.dart';
import 'package:tp_5n6/main.dart';
import 'package:tp_5n6/signIn.dart';
import 'package:tp_5n6/transfer.dart';

import 'models/singleton.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'KickMyFlutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _controllerUsername;
  late TextEditingController _controllerPassword;

  void initState() {
    _controllerPassword = TextEditingController();
    _controllerUsername = TextEditingController();
  }

  Future<void> _signin(String username, String password) async {
    SigninRequest s = SigninRequest();
    s.username = username;
    s.password = password;
    try {
      SigninResponse signinResponse = await SingletonDio.signin(s);
      print(signinResponse.username);
    }
    catch (e) {
      print(e);
      throw(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controllerUsername,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Username",
              ),
            ),
            TextField(
              obscureText: true,
              controller: _controllerPassword,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Password",
              ),
            ),
            TextButton(onPressed: () async {
              await _signin(_controllerUsername.text, _controllerPassword.text);
              Navigator.push(context, MaterialPageRoute(builder: (context) => Main()));
            },
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                primary: Colors.white,
              ),
              child: Text("Log In"),
            ),
            TextButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
            },
              child: Text("Sign In"),
            ),
          ],
        ),
      ),
    );
  }
}
