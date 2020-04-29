import 'package:NewsApp/pages/register.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

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
        .catchError((error) {
      if (error.message ==
          "The password is invalid or the user does not have a password.") {
        Toast.show("Password Incorrect , Try Again 😑", context,
            gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
      } else if (error.message == "The email address is badly formatted.") {
        Toast.show("Please Type in the correct Email id 😕", context,
            gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
      } else if (error.message ==
          "There is no user record corresponding to this identifier. The user may have been deleted.") {
        Toast.show("Oppsie , No User found for given Email id 😅", context,
            gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
      } else {
        Toast.show("Cant Reach Servers 😴", context,
            gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
      }
      print(error.message);
    }).then((res) {
      _setdata("uid", res.user.uid);
      _setdata("username", res.user.displayName);
      Toast.show("Cheers 🍷, login sucessful", context,
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
                          "Login",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      padding: EdgeInsets.all(50),
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
                                  hintText: "example : username@domain.com"),
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
                                      "must contain atleast 6 characters"),
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
                        child: Text("Login"),
                        onPressed: () => _login(emailid, password)),
                    SizedBox(
                      height: 20,
                    ),
                    CupertinoButton(
                        color: Colors.pinkAccent[200],
                        child: Text("Create new Account"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => Register()));
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    CupertinoButton(
                        child: Text("Forgot password ?"), onPressed: null)
                  ],
                ))));
  }
}
