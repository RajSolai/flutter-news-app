import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String uid;

  _navigator() async {
    await Future.delayed(Duration(seconds: 3));
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    uid = _prefs.getString("uid");
    print("saved uid is " + _prefs.getString("uid").toString());
    if (uid == null) {
      Navigator.pushReplacementNamed(context, "/login");
    } else {
      Navigator.pushReplacementNamed(context, "/home");
    }
  }

  @override
  void initState() {
    super.initState();
    _navigator();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
     // backgroundColor: Colors.pinkAccent[200],
      body: Container(
        padding: EdgeInsets.only(top: 400),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                "News Cards",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 200,
              ),
              CircularProgressIndicator()
            ],
          ),
        ),
      ),
    ));
  }
}
