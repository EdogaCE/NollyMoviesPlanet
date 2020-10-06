import 'dart:async';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nollymovies/facebook.dart';
import 'package:nollymovies/instagram.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

// import 'package:FlutterToast_example/toast_context.dart';
// import 'package:FlutterToast_example/toast_context.dart';
import 'package:http/http.dart' as http;

void main() => runApp(
      MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()),
    );

class MyApp extends StatelessWidget {
  MyApp({
    Key key,
  }) : super(key: key);
  static Future<String> get _url async {
    await Future.delayed(Duration(seconds: 5));
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // i am connected to a mobile network
      // Fluttertoast.showToast(msg: 'SLIDE LEFT FOR THE MENU');
      return 'https://www.nollymoviesplanet.com';
    } else if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(msg: 'NOT CONNECTTED TO THE INTERNET');
    } else {
      print('Loading');
    }
  }

  @override
  Widget build(BuildContext context) {
    final appcastURL = 'https://www.mydomain.com/myappcast.xml';
    final cfg = AppcastConfiguration(url: appcastURL, supportedOS: ['android']);
    return Scaffold(
      appBar: AppBar(title: Text("NOLLYMOVIES PLANET TV")),
      body: UpgradeAlert(
        appcastConfig: cfg,
        debugLogging: true,
        child: Center(
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
                  child: ListTile(title: Text('BLOG'), leading: Blog()
                      // Icon(Icons.person, color: Colors.red),
                      ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Url()));
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
                onTap: () {},
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
}

_launchURL() async {
  const url = 'https://facebook.com';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class WebViewWidget extends StatefulWidget {
  final String url;
  WebViewWidget({this.url});
  // @overide
  // Widget build (BuildContext context){
// return WebViewScaffold(
// url:url, withJavascript:true,withLocalStorage: true, appCacheEnabled: false, withZoom:true, ignoreSSLErrors:true,);
// )
  // }

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

class Blog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
        // Icon(Icons.add_to_home_screen,);
        ImageIcon(
      AssetImage(
        'assets/nolly alpha.png',
      ),
      color: Colors.blue,
      // size: 50,

      // color: null,
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// void main() => runApp(

//        MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: WebViewExample(),
//       ),

// );

// const String kNavigationExamplePage = '''
// <!DOCTYPE html><html>
// <head><title>Navigation Delegate Example</title></head>
// <body>
// <p>
// The navigation delegate is set to block navigation to the youtube website.
// </p>
// <ul>
// <ul><a href="https://www.youtube.com/">https://www.youtube.com/</a></ul>
// <ul><a href="https://www.google.com/">https://www.google.com/</a></ul>
// </ul>
// </body>
// </html>
// ''';

// class ProgressIndicator extends StatelessWidget {
//   StreamController<int> _events;
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         color: Colors.greenAccent,
//         height: 400.0,
//         width: 300.0,
//         child: Container(
//           child: StreamBuilder<int>(
//             stream: _events.stream,
//             builder: (context, AsyncSnapshot<int> snapshot) {
//               if (snapshot.connectionState != ConnectionState.done) {
//                 return CircularProgressIndicator(backgroundColor: Colors.blue);
//               } else {
//                 return Text(
//                   'Hello!',
//                   style: TextStyle(fontSize: 40.0),
//                   textAlign: TextAlign.center,
//                 );
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Future buildText() {
//     return new Future.delayed(
//         const Duration(seconds: 5), () => print('waiting'));
//   }
// }

// class WebViewExample extends StatefulWidget {
//   @override
//   _WebViewExampleState createState() => _WebViewExampleState();
// }

// class _WebViewExampleState extends State<WebViewExample> {
//   final Completer<WebViewController> _controller =
//       Completer<WebViewController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('IFIS'),
//         // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
//         actions: <Widget>[
//           NavigationControls(_controller.future),
//           SampleMenu(_controller.future),
//         ],
//       ),
//       // We're using a Builder here so we have a context that is below the Scaffold
//       // to allow calling Scaffold.of(context) so we can show a snackbar.
//       body: Builder(builder: (BuildContext context) {
//         return WebView(
//           initialUrl: 'https://financessystemstrategies.com',
//           javascriptMode: JavascriptMode.unrestricted,
//           onWebViewCreated: (WebViewController webViewController) {
//             _controller.complete(webViewController);
//           },
//           // TODO(iskakaushik): Remove this when collection literals makes it to stable.
//           // ignore: prefer_collection_literals
//           javascriptChannels: <JavascriptChannel>[
//             _toasterJavascriptChannel(context),
//           ].toSet(),
//           navigationDelegate: (NavigationRequest request) {
//             if (request.url.startsWith('https://www.google.com')) {
//               print('blocking navigation to $request}');
//               return NavigationDecision.prevent;
//             }
//             print('allowing navigation to $request');
//             return NavigationDecision.navigate;
//           },
//           onPageStarted: (String url) {
//             print('Page started loading: $url');
//           },
//           onPageFinished: (String url) {
//             print('Page finished loading: $url');
//           },
//           gestureNavigationEnabled: true,
//         );
//       }),
//       floatingActionButton: favoriteButton(),
//     );
//   }

//   JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
//     return JavascriptChannel(
//         name: 'Toaster',
//         onMessageReceived: (JavascriptMessage message) {
//           Scaffold.of(context).showSnackBar(
//             SnackBar(content: Text(message.message)),
//           );
//         });
//   }

//   Widget favoriteButton() {
//     return FutureBuilder<WebViewController>(
//         future: _controller.future,
//         builder: (BuildContext context,
//             AsyncSnapshot<WebViewController> controller) {
//           if (controller.hasData) {
//             return FloatingActionButton(
//               onPressed: () async {
//                 final String url = await controller.data.currentUrl();
//                 Scaffold.of(context).showSnackBar(
//                   SnackBar(content: Text('Favorited $url')),
//                 );
//               },
//               child: const Icon(Icons.favorite),
//             );
//           }
//           return Container();
//         });
//   }
// }

// enum MenuOptions {
//   showUserAgent,
//   listCookies,
//   clearCookies,
//   addToCache,
//   listCache,
//   clearCache,
//   navigationDelegate,
// }

// class SampleMenu extends StatelessWidget {
//   SampleMenu(this.controller);

//   final Future<WebViewController> controller;
//   final CookieManager cookieManager = CookieManager();

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<WebViewController>(
//       future: controller,
//       builder:
//           (BuildContext context, AsyncSnapshot<WebViewController> controller) {
//         return PopupMenuButton<MenuOptions>(
//           onSelected: (MenuOptions value) {
//             switch (value) {
//               case MenuOptions.showUserAgent:
//                 _onShowUserAgent(controller.data, context);
//                 break;
//               case MenuOptions.listCookies:
//                 _onListCookies(controller.data, context);
//                 break;
//               case MenuOptions.clearCookies:
//                 _onClearCookies(context);
//                 break;
//               case MenuOptions.addToCache:
//                 _onAddToCache(controller.data, context);
//                 break;
//               case MenuOptions.listCache:
//                 _onListCache(controller.data, context);
//                 break;
//               case MenuOptions.clearCache:
//                 _onClearCache(controller.data, context);
//                 break;
//               case MenuOptions.navigationDelegate:
//                 _onNavigationDelegateExample(controller.data, context);
//                 break;
//             }
//           },
//           itemBuilder: (BuildContext context) => <PopupMenuItem<MenuOptions>>[
//             PopupMenuItem<MenuOptions>(
//               value: MenuOptions.showUserAgent,
//               child: const Text('Show user agent'),
//               enabled: controller.hasData,
//             ),
//             const PopupMenuItem<MenuOptions>(
//               value: MenuOptions.listCookies,
//               child: Text('List cookies'),
//             ),
//             const PopupMenuItem<MenuOptions>(
//               value: MenuOptions.clearCookies,
//               child: Text('Clear cookies'),
//             ),
//             const PopupMenuItem<MenuOptions>(
//               value: MenuOptions.addToCache,
//               child: Text('Add to cache'),
//             ),
//             const PopupMenuItem<MenuOptions>(
//               value: MenuOptions.listCache,
//               child: Text('List cache'),
//             ),
//             const PopupMenuItem<MenuOptions>(
//               value: MenuOptions.clearCache,
//               child: Text('Clear cache'),
//             ),
//             const PopupMenuItem<MenuOptions>(
//               value: MenuOptions.navigationDelegate,
//               child: Text('Navigation Delegate example'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _onShowUserAgent(
//       WebViewController controller, BuildContext context) async {
//     // Send a message with the user agent string to the Toaster JavaScript channel we registered
//     // with the WebView.
//     await controller.evaluateJavascript(
//         'Toaster.postMessage("User Agent: " + navigator.userAgent);');
//   }

//   void _onListCookies(
//       WebViewController controller, BuildContext context) async {
//     final String cookies =
//         await controller.evaluateJavascript('document.cookie');
//     Scaffold.of(context).showSnackBar(SnackBar(
//       content: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           const Text('Cookies:'),
//           _getCookieList(cookies),
//         ],
//       ),
//     ));
//   }

//   void _onAddToCache(WebViewController controller, BuildContext context) async {
//     await controller.evaluateJavascript(
//         'caches.open("test_caches_entry"); localStorage["test_localStorage"] = "dummy_entry";');
//     Scaffold.of(context).showSnackBar(const SnackBar(
//       content: Text('Added a test entry to cache.'),
//     ));
//   }

//   void _onListCache(WebViewController controller, BuildContext context) async {
//     await controller.evaluateJavascript('caches.keys()'
//         '.then((cacheKeys) => JSON.stringify({"cacheKeys" : cacheKeys, "localStorage" : localStorage}))'
//         '.then((caches) => Toaster.postMessage(caches))');
//   }

//   void _onClearCache(WebViewController controller, BuildContext context) async {
//     await controller.clearCache();
//     Scaffold.of(context).showSnackBar(const SnackBar(
//       content: Text("Cache cleared."),
//     ));
//   }

//   void _onClearCookies(BuildContext context) async {
//     final bool hadCookies = await cookieManager.clearCookies();
//     String message = 'There were cookies. Now, they are gone!';
//     if (!hadCookies) {
//       message = 'There are no cookies.';
//     }
//     Scaffold.of(context).showSnackBar(SnackBar(
//       content: Text(message),
//     ));
//   }

//   void _onNavigationDelegateExample(
//       WebViewController controller, BuildContext context) async {
//     final String contentBase64 =
//         base64Encode(const Utf8Encoder().convert(kNavigationExamplePage));
//     await controller.loadUrl('data:text/html;base64,$contentBase64');
//   }

//   Widget _getCookieList(String cookies) {
//     if (cookies == null || cookies == '""') {
//       return Container();
//     }
//     final List<String> cookieList = cookies.split(';');
//     final Iterable<Text> cookieWidgets =
//         cookieList.map((String cookie) => Text(cookie));
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       mainAxisSize: MainAxisSize.min,
//       children: cookieWidgets.toList(),
//     );
//   }
// }

// class NavigationControls extends StatelessWidget {
//   const NavigationControls(this._webViewControllerFuture)
//       : assert(_webViewControllerFuture != null);

//   final Future<WebViewController> _webViewControllerFuture;

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<WebViewController>(
//       future: _webViewControllerFuture,
//       builder:
//           (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
//         final bool webViewReady =
//             snapshot.connectionState == ConnectionState.done;
//         final WebViewController controller = snapshot.data;
//         return Row(
//           children: <Widget>[
//             IconButton(
//               icon: const Icon(Icons.arrow_back_ios),
//               onPressed: !webViewReady
//                   ? null
//                   : () async {
//                       if (await controller.canGoBack()) {
//                         await controller.goBack();
//                       } else {
//                         Scaffold.of(context).showSnackBar(
//                           const SnackBar(content: Text("No back history item")),
//                         );
//                         return;
//                       }
//                     },
//             ),
//             IconButton(
//               icon: const Icon(Icons.arrow_forward_ios),
//               onPressed: !webViewReady
//                   ? null
//                   : () async {
//                       if (await controller.canGoForward()) {
//                         await controller.goForward();
//                       } else {
//                         Scaffold.of(context).showSnackBar(
//                           const SnackBar(
//                               content: Text("No forward history item")),
//                         );
//                         return;
//                       }
//                     },
//             ),
//             IconButton(
//               icon: const Icon(Icons.replay),
//               onPressed: !webViewReady
//                   ? null
//                   : () {
//                       controller.reload();
//                     },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
// // import 'package:flutter/material.dart';
// // import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
// // import 'package:webview_flutter/webview_flutter.dart';

// // void main() => runApp(
// //       MaterialApp(

// //         // WebView(),
// //         debugShowCheckedModeBanner: false,
// //         // home: HomePage(),
// //         // ),
// //       ),
// //     );
