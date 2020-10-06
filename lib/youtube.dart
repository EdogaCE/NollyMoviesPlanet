import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nollymovies/instagram.dart';
import 'package:nollymovies/main.dart';
import 'package:nollymovies/facebook.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class Youtube extends StatelessWidget {
  static Future<String> get _url async {
    await Future.delayed(Duration(seconds: 5));
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // i am connected to a mobile network
      return 'https://www.youtube.com/channel/UCDgdsiMwySIWW_tBAMMfLKQ';
    } else if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(msg: 'NOT CONNECTTED TO THE INTERNET');
    } else {
      print('Loading');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text("NOLLYMOVIES PLANET TV")),
        body: Center(
          child: FutureBuilder(
            future: _url,
            builder: (BuildContext context, AsyncSnapshot snapshot) =>
                snapshot.hasData
                    ? WebViewWidget(
                        url: snapshot.data,
                      )
                    : Center(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                strokeWidth: 7.0,
                              ),
                              Text(
                                'loading...',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ]),
                      ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
              // padding: EdgeInsets.zero,
              children: <Widget>[
                //header
                DrawerHeader(
                  // child: Text(''),

                  child: CircleAvatar(
                    backgroundImage: AssetImage("images/nolly.png"),
                  ),

                  decoration: BoxDecoration(color: Colors.black),
                ),
                //body
                Container(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyApp()));
                    },
                    child: ListTile(
                      title: Text('BLOG'),
                      leading: ImageIcon(AssetImage('assets/nolly alpha.png'),
                          color: Colors.blue),
                      // Icon(Icons.person, color: Colors.red),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Url()));
                  },
                  child: ListTile(
                    title: Text('FACEBOOK PAGE'),
                    leading:
                        // Icon(
                        //   Icons.blur_circular,
                        // ),
                        ImageIcon(AssetImage('assets/face alpha.png'),
                            color: Colors.blue),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Instagram()));
                  },
                  child: ListTile(
                    title: Text('INSTAGRAM PAGE'),
                    leading:
                        // Icon(
                        //   Icons.blur_circular,
                        // ),
                        ImageIcon(
                      AssetImage(
                        'assets/insta alpha.png',
                      ),
                      color: Colors.red,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Youtube()));
                  },
                  child: ListTile(
                    title: Text('YOUTUBE CHANNEL'),
                    leading:
                        // Icon(
                        //   Icons.blur_circular,
                        // ),
                        ImageIcon(
                      AssetImage('assets/you alpha.png'),
                      color: Colors.red,
                      // size: 50,
                    ),
                  ),
                )
              ]),
        ),
      );
}

class WebViewWidget extends StatefulWidget {
  final String url;
  WebViewWidget({this.url});

  @override
  _WebViewWidget createState() => _WebViewWidget();
}

class _WebViewWidget extends State<WebViewWidget> {
  WebView _webView;
  @override
  void initState() {
    super.initState();
    _webView = WebView(
      initialUrl: widget.url,
      javascriptMode: JavascriptMode.unrestricted,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _webView = null;
  }

  @override
  Widget build(BuildContext context) => _webView;
}
