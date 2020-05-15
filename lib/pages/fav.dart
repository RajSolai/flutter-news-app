import 'package:NewsCards/services/Article.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toast/toast.dart';

class Fav extends StatefulWidget {
  @override
  _FavState createState() => _FavState();
}

class _FavState extends State<Fav> {
  String uid;
  var favData;

  _getuid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString('uid');
    });
  }

  @override
  void initState() {
    super.initState();
    _getuid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(
      children: <Widget>[
        SizedBox(
          height: 40,
        ),
        Container(
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              SizedBox(
                width: 10,
              ),
              Container(
                child: Text(
                  'Favorites 💕',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection(uid).snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return Text("Errot in Snapshot");
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return SingleChildScrollView(
                        child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 100,
                            width: 100,
                            child:
                                Image.asset("./assets/icons/loading-logo.png"),
                          ),
                          Center(
                            child: Text(
                              "Fetching your Favorites!",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: Text(
                              "This might take a second",
                              style: TextStyle(
                                  fontSize: 16, fontStyle: FontStyle.italic),
                            ),
                          )
                        ],
                      ),
                    ));
                  } else if (snapshot.data.documents == null) {
                    return Center(
                      child: Text(
                          'Add Articles to the Favorites by clicking ❤️ icon'),
                    );
                  } else {
                    return ListView(
                      padding: EdgeInsets.all(10),
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                        return GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => InappBrowserpage(
                                        newsurl: document['newsurl'],
                                      ))),
                          onDoubleTap: () {
                            Toast.show('Removed From Favorites', context,
                                duration: Toast.LENGTH_LONG);
                            document.reference.delete();
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 100,
                                  width: 100,
                                  padding: EdgeInsets.all(10),
                                  child: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(document['newsimg']),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        document['newstitle'],
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }
                }))
      ],
    )));
  }
}
