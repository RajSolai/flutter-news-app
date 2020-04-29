import 'package:NewsApp/pages/login.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';
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
        .catchError((error) {
      if (error.message ==
          "The given password is invalid. [ Password should be at least 6 characters ]") {
        Toast.show("Password must contain alteast 6 character 😕", context,
            gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
      } else if (error.message == "The email address is badly formatted.") {
        Toast.show("Please Type in the correct Email id 🙄", context,
            gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
      } else if (error.message ==
          "The email address is already in use by another account.") {
        Toast.show(error.message+"🙅", context,
            gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
      } else {
        Toast.show("Cant Reach Servers 😴", context,
            gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
      }
      print(error.message);
    }).then((res) {
      // user update info
      UserUpdateInfo info = new UserUpdateInfo();
      info.displayName = displayname;
      res.user.updateProfile(info);
      _setdata("uid", res.user.uid);
      _setdata("username", displayname);
      Toast.show("Cheers 🍷, your account is created", context,
          gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
      print("user created with email and password");
      Navigator.of(context).pushReplacementNamed("/home");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 75),
                      child: Text(
                        "Create New Account",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 25),
                    Container(
                      padding: EdgeInsets.all(50),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Nick Name",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          TextField(
                              decoration: InputDecoration(
                                  hintText: "Provide your Name"),
                              onChanged: (value) {
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
                              decoration: InputDecoration(
                                  hintText: "eg: username@domain.com"),
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
                          TextField(
                              decoration: InputDecoration(
                                  hintText:
                                      'must contain atleast 6 characters'),
                              onChanged: (value) {
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
                      child: Text("Create Account"),
                      onPressed: () {
                        _signUp(emailid, password, displayName);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CupertinoButton(
                      child: Text("Login"),
                      onPressed: () {
                        Navigator.push(context,
                            CupertinoPageRoute(builder: (context) => Login()));
                      },
                    ),
                  ],
                ))));
  }
}
