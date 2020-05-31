import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LoadingWidget extends StatefulWidget {
  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 100,
            width: 100,
            child: Image.asset("./assets/icons/loading-logo.png"),
          ),
          Center(
            child: Text(
              "Fetching your News!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              "This might take a second",
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
          )
        ],
      ),
    );
  }
}
