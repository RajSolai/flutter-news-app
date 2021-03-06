import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:NewsCards/pages/account.dart';
import 'package:NewsCards/services/dict.dart';

class CustomAppBar extends StatelessWidget {
  final title, emoji, dp;
  CustomAppBar({this.title, this.emoji, this.dp});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: <Widget>[
        SizedBox(
          width: 20,
        ),
        Container(
            margin: EdgeInsets.only(top: 40),
            height: 40,
            width: 40,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => Account()));
              },
              child: CircleAvatar(
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image(
                  image: AssetImage(
                    this.dp == 'cat' ? dpDict[1] : dpDict[0],
                  ),
                ),
              )),
            )),
        SizedBox(
          width: 5,
        ),
        Container(
          margin: EdgeInsets.only(top: 40, bottom: 0),
          padding: EdgeInsets.all(10),
          child: Text(
            this.title + " " + this.emoji,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          width: 80,
        ),
      ],
    ));
  }
}
