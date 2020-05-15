import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InappBrowserpage extends StatefulWidget {
  final newsurl;
  InappBrowserpage({this.newsurl});

  @override
  _InappBrowserpageState createState() => _InappBrowserpageState();
}

class _InappBrowserpageState extends State<InappBrowserpage> {
  var _stackIndex = 1;

  void _handleLoad(String value) {
    setState(() {
      _stackIndex = 0;
    });
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
                    'Article 📖',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: IndexedStack(
            index: _stackIndex,
            children: [
              Column(
                children: <Widget>[
                  Expanded(
                      child: WebView(
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: widget.newsurl,
                    onPageFinished: _handleLoad,
                  )),
                ],
              ),
              Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ))
        ],
      ),
    ));
  }
}
