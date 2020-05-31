import 'package:NewsCards/pages/fav.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:NewsCards/services/dict.dart';

class Account extends StatefulWidget {
  Account({Key key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String accountName;
  String dp;

  _getAccount() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String temp = _prefs.getString("username");
    String tempdp = _prefs.getString('dpid');
    setState(() {
      accountName = temp;
      dp = tempdp;
    });
  }

  _signOut() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.signOut().then((res) {
      _prefs.remove("username");
      _prefs.remove("uid");
    });
    Navigator.pushReplacementNamed(context, "/login").then((res) {
      Toast.show('Sign Out Successfull 👍', context,
          duration: Toast.LENGTH_LONG);
    });
  }

  _deleteAccount() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.currentUser().then((user) {
      user.delete();
    });
    Navigator.pushReplacementNamed(context, "/login").then((res) {
      Toast.show('Account Deleted Successfully 👍', context,
          duration: Toast.LENGTH_LONG);
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
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 70,
                  ),
                  Container(
                    child: Text(
                      accountName == null ? "Name not Available" : accountName,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Container(
                    child: CircleAvatar(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image(
                        image: AssetImage(
                          dp == 'cat' ? dpDict[1] : dpDict[0],
                        ),
                      ),
                    )),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 40, right: 40),
              margin: EdgeInsets.only(top: 30, right: 0),
              child: Text(
                "\"Citizens in a democracy need diverse sources of news and information.\"",
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 60),
              child: Column(
                children: <Widget>[
                  CupertinoButton(
                      color: Colors.pink,
                      child: Text("Favorites"),
                      onPressed: () {
                        Navigator.push(context,
                            CupertinoPageRoute(builder: (context) => Fav()));
                      }),
                  SizedBox(
                    height: 30,
                  ),
                  CupertinoButton(
                      color: Colors.pink,
                      child: Text("Delete Account"),
                      onPressed: () => _deleteAccount()),
                  SizedBox(
                    height: 30,
                  ),
                  CupertinoButton(
                      color: Colors.pink,
                      child: Text("Sign Out"),
                      onPressed: () => _signOut()),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: AdmobBanner(
                        adUnitId: 'ca-app-pub-3940256099942544/6300978111',
                        adSize: AdmobBannerSize.BANNER),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
