import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Fav extends StatefulWidget {
  @override
  _FavState createState() => _FavState();
}

class _FavState extends State<Fav> {
  Object favObj;
  String uid = "sample";

  _getuid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.get("uid");
  }

  @override
  void initState() {
    super.initState();
    _getuid();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("fav works"),
    );
  }
}
