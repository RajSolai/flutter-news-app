import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share/share.dart';
import 'package:toast/toast.dart';
import 'package:vibration/vibration.dart';
import 'package:NewsCards/services/Article.dart';
import 'package:flare_flutter/flare_actor.dart';

class NewsCard extends StatefulWidget {
  final title, imgurl, content, uid, url;
  NewsCard({this.title, this.imgurl, this.content, this.uid, this.url});

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  // states for animation
  String animationState = "none";
  // handling no image input
  String noImg(input) {
    if (input == null) {
      return 'https://firebasestorage.googleapis.com/v0/b/flutter-fire-a6262.appspot.com/o/noimg.png?alt=media&token=53379f9a-b08e-43e0-b42c-c336145e4ccf';
    } else {
      return input;
    }
  }

  // handling text errors
  String stringNuller(input) {
    if (input == null) {
      return "Null";
    } else {
      return input;
    }
  }

  _saveToFav(title, imgurl, uid, url) {
    Firestore _db = Firestore.instance;
    var data = {
      'newstitle': title.toString().substring(0, 20) + '..',
      'newsimg': imgurl,
      'newsurl': url
    };
    _db.collection(uid).add(data).then((res) {
      setState(() {
        animationState = "color";
      });
      Vibration.vibrate(duration: 50);
      Toast.show('Article added to Favorites', context,
          duration: Toast.LENGTH_LONG);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        width: double.maxFinite,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: <Widget>[
              Container(
                height: 200,
                width: double.maxFinite,
                child: ClipRRect(
                    child: Image.network(
                      noImg(this.widget.imgurl),
                      width: double.maxFinite,
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    this.widget.title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  stringNuller(this.widget.title),
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
                              CupertinoPageRoute(
                                  builder: (context) => InappBrowserpage(
                                      newsurl: this.widget.url)));
                        },
                      ),
                    ),
                    Spacer(flex: 2),
                    GestureDetector(
                      onTap: () => _saveToFav(this.widget.title,
                          this.widget.imgurl, this.widget.uid, this.widget.url),
                      child: Container(
                        height: 50,
                        width: 50,
                        child: FlareActor(
                          "./assets/animations/Favorite-icon.flr",
                          fit: BoxFit.contain,
                          alignment: Alignment.center,
                          animation: animationState,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.share),
                      onPressed: () => Share.share(this.widget.url),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
