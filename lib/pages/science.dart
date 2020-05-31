import 'dart:convert';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:NewsCards/components/newscard.dart';
import 'package:NewsCards/components/LoadingWidget.dart';
import 'package:NewsCards/components/CustomAppBar.dart';
import 'package:NewsCards/services/Api.dart';

// Actually Health page !!!
class Science extends StatefulWidget {
  @override
  _ScienceState createState() => _ScienceState();
}

class _ScienceState extends State<Science> {
  // The api url with key
  String apiurl = apiMap["health"];
  // List typed data that stores the news got from api
  Map data;
  List news;
  String uid;
  String dp;

  _getDp() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      dp = _prefs.getString('dpid');
      uid = _prefs.getString('uid');
    });
  }

  // Async fun to get the data from url and decode the json response
  Future get() async {
    await http.get(apiurl).then((res) {
      data = json.decode(res.body);
      _getDp();
      setState(() {
        news = data["articles"];
      });
    });
  }

  // on widget init
  @override
  void initState() {
    super.initState();
    get();
  }

  @override
  Widget build(BuildContext context) {
    if (news == null) {
      return SingleChildScrollView(
        child: LoadingWidget(),
      );
    } else {
      return Container(
        child: Column(
          children: <Widget>[
            CustomAppBar(
              title: "Health",
              emoji: "💊",
              dp: this.dp,
            ),
            Container(
              child: Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.all(0),
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: news == null ? 0 : news.length,
                      itemBuilder: (BuildContext context, int index) {
                        return NewsCard(
                            title: news[index]['title'],
                            imgurl: news[index]['urlToImage'],
                            content: news[index]['content'],
                            uid: this.uid,
                            url: news[index]['url']);
                      })),
            )
          ],
        ),
      );
    }
  }
}
