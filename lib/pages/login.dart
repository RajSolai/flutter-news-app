import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _fireauth = FirebaseAuth.instance;
  String emailid;
  String password;
  String displayName;

  Future _setdata(key, data) async {
    final _prefs = await SharedPreferences.getInstance();
    _prefs.setString(key, data);
  }

  void _login(email, pass) async {
    await _fireauth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((res) {
      _setdata("uid", res.user.uid);
      _setdata("username", res.user.displayName);
      print("user created with email and password");
      Navigator.of(context).pushReplacementNamed("/home");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
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
                            "Email Address",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          TextField(
                              autofocus: true,
                              decoration: InputDecoration(
                                hintText: "example : username@domain.com"
                              ),
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
                                hintText: "must contain atleast 6 characters"
                              ),
                            onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          })
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CupertinoButton(
                      color: Colors.pinkAccent[200],
                      child: Text(
                        "Login"
                      ),
                      onPressed: ()=>_login(emailid,password)
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CupertinoButton(
                      color: Colors.pinkAccent[200],
                      child: Text(
                        "Create new Account"
                      ),
                      onPressed: ()=>Navigator.pushNamed(context, "/register")
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CupertinoButton(
                      child: Text(
                        "Forgot password ?"
                      ), 
                      onPressed: null
                    )
                  ],
                ))));
  }
}
