import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account extends StatefulWidget {
  Account({Key key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String accountName;

  _getAccount() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String temp = _prefs.getString("username");
    setState(() {
      accountName = temp;
    });
  }

  @override
  void initState() {
    super.initState();
    _getAccount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 40),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: Text(
                        "Account 🛠️",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )),
            Container(
              margin: EdgeInsets.only(top: 40, right: 130),
              child: Text(
                "Hello there !",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40, right: 180),
              child: Text(
                accountName == null ? "Name not Available" : accountName,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 40,
                right: 40
              ),
              margin: EdgeInsets.only(top: 40, right: 0),
              child: Text(
                "\"Citizens in a democracy need diverse sources of news and information.\"",
                style: TextStyle(fontSize: 16 , fontStyle: FontStyle.italic),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 90),
              child: Column(
                children: <Widget>[
                  CupertinoButton(
                      color: Colors.pink,
                      child: Text("Delete Account"),
                      onPressed: () => print('hellp')),
                      SizedBox(
                        height: 30,
                      ),
                      CupertinoButton(
                      color: Colors.pink,
                      child: Text("Sign Out"),
                      onPressed: () => print('hellp'))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
