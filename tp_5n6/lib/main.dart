import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tp_5n6/http_lib.dart';
import 'package:tp_5n6/home.dart';
import 'package:tp_5n6/signIn.dart';
import 'package:tp_5n6/transfer.dart';
import 'package:tp_5n6/i18n/intl_localization.dart';

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
      localizationsDelegates: [
        //DemoDelegate(), //TODO delegate
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('fr'),
      ],
/*
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),*/
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
  String errorMessage = '';

  void initState() {
    _controllerPassword = TextEditingController();
    _controllerUsername = TextEditingController();
  }

  void validation() {
    String u = _controllerUsername.text;
    String p = _controllerPassword.text;
    if (u.isEmpty && p.isEmpty) {
      throw('Both filed are empty.');
    }
    if (u.isEmpty) {
      throw('Username field is empty.');
    }
    if (p.isEmpty) {
      throw('Password field is empty');
    }
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
        //print(e);
        rethrow;
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
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: Locs.of(context).trans('USERNAME'),
              ),
            ),
            TextField(
              obscureText: true,
              controller: _controllerPassword,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Password",
              ),
            ),
            TextButton(onPressed: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              //SmartDialog.showLoading();
              try {
                validation();
                await _signin(_controllerUsername.text, _controllerPassword.text);
                Navigator.push(context, MaterialPageRoute(builder: (context) => Main()));
                //SmartDialog.dismiss();
              }
              catch (e) {
                if (e is DioError) {
                  if (e.response?.data == 'InternalAuthenticationServiceException') {
                    errorMessage = 'Username or password is wrong.';
                  }
                }

                final snackBar = SnackBar(
                  content: Text(e.toString()),
                );

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                //SmartDialog.dismiss();
                throw(e);
              }
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
