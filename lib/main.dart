import 'package:NewsApp/pages/fav.dart';
import 'package:NewsApp/pages/login.dart';
import 'package:NewsApp/pages/splash.dart';
import 'package:flutter/material.dart';
import 'pages/register.dart';
import 'home.dart';

main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "News Cards",
      home: Splash(),
      routes: {
        "/home": (context) => Home(),
        "/register": (context) => Register(),
        "/fav": (context) => Fav(),
        "/login": (context) => Login()
      },
      theme: ThemeData(
          fontFamily: 'VisueltPro',
          accentColor: Colors.pinkAccent,
          appBarTheme: AppBarTheme(color: Colors.pinkAccent),
          buttonColor: Colors.pinkAccent[200],
          cardTheme: CardTheme(elevation: 10)
      ),
      darkTheme: ThemeData(
        fontFamily: 'VisueltPro',
        brightness: Brightness.dark,
        cardTheme: CardTheme( elevation: 10),
      ),
    );
  }
}
