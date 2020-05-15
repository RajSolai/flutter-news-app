import 'dart:convert';
import 'package:NewsCards/pages/account.dart';
import 'package:NewsCards/services/Article.dart';
import 'package:NewsCards/services/dict.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:vibration/vibration.dart';

class Tech extends StatefulWidget {
  @override
  _TechState createState() => _TechState();
}

class _TechState extends State<Tech> {
  // The api url with key
  String apiurl =
      "http://newsapi.org/v2/top-headlines?country=in&category=technology&apiKey=b0404985f10f4304bfea8b247262c9b4";

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

  _saveToFav(_newsData) {
    Firestore _db = Firestore.instance;
    var data = {
      'newstitle': _newsData['title'].toString().substring(0, 20) + '..',
      'newsimg': _newsData['urlToImage'],
      'newsurl': _newsData['url']
    };
    _db.collection(uid).add(data).then((res) {
      Toast.show('Article added to Favorites', context,
          duration: Toast.LENGTH_LONG);
      Vibration.vibrate(duration: 200);
    });
  }

  // on widget init
  @override
  void initState() {
    super.initState();
    get();
  }

  // handling text errors
  String stringNuller(input) {
    if (input == null) {
      return "Null";
    } else {
      return input;
    }
  }

  // handling no image input
  String noImg(input) {
    if (input == null) {
      return 'https://kinsta.com/wp-content/uploads/2018/02/wordpress-photo-gallery-plugins.png';
    } else {
      return input;
    }
  }

  // build the widget
  @override
  Widget build(BuildContext context) {
    if (news == null) {
      return SingleChildScrollView(
          child: Container(
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
      ));
    } else {
      return Container(
        child: Column(
          children: <Widget>[
            Row(
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
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => Account()));
                      },
                      child: CircleAvatar(
                          child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image(
                          image: AssetImage(
                            dp == 'cat' ? dpDict[1] : dpDict[0],
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
                    "Tech 👩🏻‍💻",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 80,
                ),
              ],
            ),
            Container(
              child: Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.all(0),
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: news == null ? 0 : news.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            padding: EdgeInsets.all(10),
                            width: double.maxFinite,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: <Widget>[
                                  ClipRRect(
                                      child: Image.network(
                                          noImg(news[index]["urlToImage"])),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                  Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        news[index]["title"],
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      stringNuller(news[index]["content"]),
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      children: <Widget>[
                                        ButtonTheme(
                                          height: 40,
                                          minWidth: 170,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: RaisedButton(
                                            color: Colors.pinkAccent[200],
                                            child: Text(
                                              "Read Full Article",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  CupertinoPageRoute(
                                                      builder: (context) =>
                                                          InappBrowserpage(
                                                            newsurl: news[index]
                                                                ['url'],
                                                          )));
                                            },
                                          ),
                                        ),
                                        Spacer(flex: 2),
                                        IconButton(
                                            icon: Icon(Icons.favorite),
                                            onPressed: () =>
                                                _saveToFav(news[index])),
                                        IconButton(
                                            icon: Icon(Icons.share),
                                            onPressed: () => Share.share(
                                                news[index]["url"])),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ));
                      })),
            )
          ],
        ),
      );
    }
  }
}
