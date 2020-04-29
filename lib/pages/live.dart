import 'dart:convert';
import 'package:NewsApp/pages/account.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:share/share.dart';

class Live extends StatefulWidget {
  @override
  _LiveState createState() => _LiveState();
}

class _LiveState extends State<Live> {
  // The api url with key
  String apiurl =
      "http://newsapi.org/v2/top-headlines?country=in&apiKey=b0404985f10f4304bfea8b247262c9b4";

  // List typed data that stores the news got from api
  Map data;
  List news;

  // Async fun to get the data from url and decode the json response
  Future get() async {
    await http.get(apiurl).then((res) {
      data = json.decode(res.body);
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

  // build / render the widget
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
                            "./assets/doggoavatar.png",
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
                    "Trending 🔥",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Container(
                child: Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.all(0),
                        scrollDirection: Axis.vertical,
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
                                    Container(
                                      height: 200,
                                      width: double.maxFinite,
                                      child: ClipRRect(
                                          child: Image.network(
                                            noImg(news[index]["urlToImage"]),
                                            width: double.maxFinite,
                                          ),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20))),
                                    ),
                                    Container(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          news[index]["title"],
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        stringNuller(news[index]["content"]),
                                        style: TextStyle(fontSize: 12),
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
                                              onPressed: () => urlLauncher
                                                  .launch(news[index]["url"]),
                                            ),
                                          ),
                                          Spacer(flex: 2),
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
                        })))
          ],
        ),
      );
    }
  }
}
