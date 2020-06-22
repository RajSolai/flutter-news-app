import 'package:NewsCards/pages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  String _gender = 'Select Gender';
  String dp;

  Future _setdata(key, data) async {
    final _prefs = await SharedPreferences.getInstance();
    _prefs.setString(key, data);
  }

  void _emailVerificationAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Email not Verified !😕"),
            content: Text(
                "Hey, It seems Your EmailId is not verified. Please Verify your EmailID for further features like adding Favorites and Reseting Password"),
            actions: <Widget>[
              CupertinoButton(
                  child: Text("Okay,I'll do it 👍"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              CupertinoButton(
                  child: Text("Nah 😑"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
  }

  void _loginAlerts(String title, String content) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              CupertinoButton(
                  child: Text("Okay 👍"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  _updateDp(String _dppref) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString('dpid', _dppref);
    setState(() {
      dp = _dppref;
    });
    if (_dppref == 'dog') {
      setState(() {
        _gender = 'Male';
      });
    } else {
      _gender = 'Female';
    }
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
        Toast.show(error.message + "🙅", context,
            gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
      } else {
        Toast.show("Cant Reach Servers 😴", context,
            gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
      }
      print(error.message);
    }).then((res) {
      // user update info
      res.user.sendEmailVerification().then((value) {
        _emailVerificationAlert();
      });
      UserUpdateInfo info = new UserUpdateInfo();
      info.displayName = displayname;
      Firestore _db = Firestore.instance;
      res.user.updateProfile(info);
      _setdata("uid", res.user.uid);
      _setdata("username", displayname);
      var data = {
        'name': displayName,
        'email': emailid,
        'gender': _gender,
        'dp': dp
      };
      _db.collection('AlluserDetails').document(email).setData(data);
      _loginAlerts("Cheers 🍷", "your account is created, Now you can Login");
      Navigator.of(context).pushReplacementNamed("/login");
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
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText:
                                      'must contain atleast 6 characters'),
                              onChanged: (value) {
                                setState(() {
                                  password = value;
                                });
                              }),
                          Container(
                            padding: EdgeInsets.all(30),
                            child: Text(_gender),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 90),
                            child: Row(
                              children: <Widget>[
                                GestureDetector(
                                  child: ClipRRect(
                                    child: Image.asset(
                                      './assets/avatar/doggoavatar.png',
                                      height: 50,
                                      width: 50,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                  ),
                                  onTap: () => _updateDp('dog'),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  child: ClipRRect(
                                    child: Image.asset(
                                      './assets/avatar/cat-icon.png',
                                      height: 50,
                                      width: 50,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                  ),
                                  onTap: () => _updateDp('dog'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
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
