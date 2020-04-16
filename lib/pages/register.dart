import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _fireauth = FirebaseAuth.instance;
  String emailid;
  String password;
  String displayName;

  Future _setdata(key, data) async {
    final _prefs = await SharedPreferences.getInstance();
    _prefs.setString(key, data);
  }

  void _signUp(email, pass, displayname) async {
    await _fireauth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((res) {
      // user update info
      UserUpdateInfo info = new UserUpdateInfo();
      info.displayName = displayname;
      res.user.updateProfile(info);
      _setdata("uid", res.user.uid);
      _setdata("username", displayname);
      print("user created with email and password");
      Navigator.of(context).pushReplacementNamed("/home");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Register"),
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Nick Name",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          TextField(onChanged: (value) {
                            setState(() {
                              displayName = value;
                            });
                          }),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: null,
                          ),
                          Text(
                            "Email Address",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          TextField(
                              autofocus: true,
                              onChanged: (value) {
                                setState(() {
                                  emailid = value;
                                });
                              }),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: null,
                          ),
                          Text(
                            "Password",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          TextField(onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          })
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: null,
                    ),
                    CupertinoButton(
                      color: Colors.pinkAccent[200],
                      child: Text(
                        "Create Account"
                      ),
                      onPressed: () {
                          _signUp(emailid, password, displayName);
                        }, 
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: null,
                    ),
                  ],
                ))));
  }
}
