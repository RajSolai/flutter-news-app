import 'package:NewsApp/pages/tech.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import './pages/entertainment.dart';
import './pages/science.dart';
import './pages/live.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String uid;
  String uname;

  final _screens = [
    Center(
      child: Live(),
    ),
    Center(
      child: Tech(),
    ),
    Center(
      child: Entertainment(),
    ),
    Center(
      child: Science(),
    )
  ];

  var _index = 0;

  _getData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final uidTemp = _prefs.getString("uid");
    final unameTemp = _prefs.getString("username");
    setState(() {
      uid = uidTemp;
      uname = unameTemp;
    });
  }


  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_index],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        backgroundColor: Colors.transparent,
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(
              title: Text(
                "Home",
                style: TextStyle(color: Colors.pinkAccent[100]),
              ),
              icon: Icon(
                Icons.home,
                color: Colors.pinkAccent,
              )),
          BottomNavigationBarItem(
            title: Text(
              "Tech",
              style: TextStyle(color: Colors.pinkAccent[100]),
            ),
            icon: Icon(
              Icons.computer,
              color: Colors.pinkAccent,
            ),
          ),
          BottomNavigationBarItem(
              title: Text(
                "Movies",
                style: TextStyle(color: Colors.pinkAccent[100]),
              ),
              icon: Icon(
                Icons.video_library,
                color: Colors.pinkAccent,
              )),
          BottomNavigationBarItem(
              title: Text("Science",
                  style: TextStyle(color: Colors.pinkAccent[100])),
              icon: Icon(
                Icons.school,
                color: Colors.pinkAccent,
              ))
        ],
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
    );
  }
}
