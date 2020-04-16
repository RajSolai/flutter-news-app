import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class InappBrowserpage extends StatelessWidget {
  final newsData;

  // handle string null errors
  String nullStr(str) {
    if (str == null) {
      return "Null";
    } else {
      return str;
    }
  }

  _launchurl(data) async {
    if (await url_launcher.canLaunch(data["url"])) {
      url_launcher.launch(data["url"]);
    } else {
      print("cannot launch");
    }
  }

  InappBrowserpage({this.newsData});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*  appBar: AppBar(
          title: Text("News Cards"),
        ), */
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Image.network(newsData["urlToImage"]),
          Container(
            child: null,
            height: 30,
          ),
          Container(child: null, height: 10),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              newsData["title"],
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            child: null,
            height: 2,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Container(
                  child: null,
                  height: 30,
                ),
                Text(
                  nullStr(newsData["content"]),
                  style: TextStyle(fontSize: 18),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: null,
                ),
                ButtonTheme(
                    height: 40,
                    minWidth: 170,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: RaisedButton(
                        color: Colors.pinkAccent[200],
                        child: Text(
                          "Read full article",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        onPressed: () => _launchurl(newsData)))
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
