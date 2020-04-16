import 'dart:convert';
import '../services/Article.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:share/share.dart';

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
      return Center(child: Text("Loading"));
    } else {
      return ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: news == null ? 0 : news.length,
          itemBuilder: (BuildContext context, int index) {
            var urlToImage = news[index]["urlToImage"];
            return Container(
                padding: EdgeInsets.all(10),
                width: double.maxFinite,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        child: Image.network(noImg(urlToImage)),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)
                        )
                      ),
                      Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            news[index]["title"],
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
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
                                  borderRadius: BorderRadius.circular(8)),
                              child: RaisedButton(
                                color: Colors.pinkAccent[200],
                                child: Text(
                                  "Read Full Article",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => InappBrowserpage(
                                          newsData: news[index],
                                        ),
                                      ));
                                },
                              ),
                            ),
                            Spacer(flex: 2),
                            IconButton(
                                icon: Icon(Icons.share),
                                onPressed: () =>
                                    Share.share(news[index]["url"])),
                          ],
                        ),
                      )
                    ],
                  ),
                ));
          });
    }
  }
}
