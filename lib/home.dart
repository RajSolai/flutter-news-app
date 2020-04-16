import 'package:NewsApp/pages/tech.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import './pages/entertainment.dart';
import './pages/science.dart';
import './pages/live.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String uid;
  String uname;

  final _screens = [
    Center(
      child: Live(),
    ),
    Center(
      child: Tech(),
    ),
    Center(
      child: Entertainment(),
    ),
    Center(
      child: Science(),
    )
  ];

  var _index =0;

  _getData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final uidTemp = _prefs.getString("uid");
    final unameTemp = _prefs.getString("username");
    setState(() {
      uid = uidTemp;
      uname = unameTemp;
    });
  }

 /*  _signOut() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var fireauth = FirebaseAuth.instance;
    fireauth.signOut();
    _prefs.clear();
  }


  _deleteAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
  */


  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
              appBar: AppBar(
                    elevation: 0,
                    title: Text("News Cards")
              ),
              body: _screens[_index],
              drawer: Drawer(
                child: ListView(
                  children: <Widget>[
                    Container(
                      height: 208,
                        child: DrawerHeader(
                        child: ListView(
                      children: <Widget>[
                        Text("Hello !"),
                        Container(
                          padding: EdgeInsets.all(15),
                        ),
                        Container(
                          height: 70,
                          width: 70,
                          margin: EdgeInsets.only(right: 208),
                          child: CircleAvatar(
                              child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image(
                              image: AssetImage(
                                "./assets/doggoavatar.png",
                              ),
                            ),
                          )),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Text(
                            uname != null ? uname : "No Data",
                            style: TextStyle(
                                fontSize: 48, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ))),
                    ListTile(
                      title: Text("Favorites"),
                      onTap: () => Navigator.pushNamed(context, "/fav"),
                    ),
                    ListTile(
                      title: Text(
                        "Sign Out",
                        style: TextStyle(color: Colors.red),
                      ),
                      onTap: null,
                    ),
                    ListTile(
                      title: Text(
                        "Delete Account",
                        style: TextStyle(color: Colors.red),
                      ),
                      onTap: null,
                    )
                  ],
                ),
              ), 
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: _index ,
            items: [
              BottomNavigationBarItem(
                title: Text("Home",style: TextStyle(color: Colors.pinkAccent[100]),),
                icon: Icon(
                  Icons.home,
                  color: Colors.pinkAccent,                  
                )
              ),
              BottomNavigationBarItem(
                title: Text("Tech",style: TextStyle(color: Colors.pinkAccent[100]),),
                icon: Icon(
                  Icons.computer,
                  color: Colors.pinkAccent,
                ),
              ),
              BottomNavigationBarItem(
                title: Text("Movies",style: TextStyle(color: Colors.pinkAccent[100]),),
                icon: Icon(
                  Icons.video_library,
                  color: Colors.pinkAccent,
                )
              ),
              BottomNavigationBarItem(
                title: Text("Science",style: TextStyle(color: Colors.pinkAccent[100])),
                icon: Icon(
                  Icons.school,
                  color: Colors.pinkAccent,
                )
              )
            ],
            onTap: (index){
              setState(() {
                _index = index;
              });
            },
          ),
        );
  }
}
