import 'package:NewsCards/pages/fav.dart';
import 'package:NewsCards/pages/login.dart';
import 'package:NewsCards/pages/splash.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'pages/register.dart';
import 'home.dart';

main() {
  Admob.initialize('ca-app-pub-7461368310551653~7736962283');
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
          appBarTheme: AppBarTheme(color: Colors.pink),
          cardTheme: CardTheme(elevation: 10)),
      darkTheme: ThemeData(
        fontFamily: 'VisueltPro',
        brightness: Brightness.dark,
        cardTheme: CardTheme(elevation: 10),
      ),
    );
  }
}
