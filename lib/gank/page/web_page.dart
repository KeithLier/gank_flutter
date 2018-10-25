import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:gank_flutter/gank/ext/share.dart';

class WebPage extends StatefulWidget {
  final Map<String, dynamic> post;

  WebPage(this.post);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new WebPageState();
  }
}

class WebPageState extends State<WebPage> {

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  bool loading = false;
  bool isLoaded = false;

  final flutterWebViewPligin = new FlutterWebviewPlugin();

  StreamSubscription<WebViewStateChanged> onStateChanged;

  void showSnack(String msg) {
    scaffoldKey.currentState.showSnackBar(
      new SnackBar(
          content: new Text(msg)
      )
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    flutterWebViewPligin.close();
    onStateChanged = flutterWebViewPligin.onStateChanged.listen((WebViewStateChanged state) {
      print("state: ${state.type}");
      if(state.type == WebViewState.finishLoad) {
        setState(() {
          isLoaded = true;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    onStateChanged.cancel();
    flutterWebViewPligin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.post['url']);
    String title = widget.post['desc'] == null ? '未知标题' : widget.post['desc'];

    List<Widget> titleContent = [];

    if(!isLoaded) {
      titleContent.add(new CupertinoActivityIndicator());
    }
    titleContent.add(new Expanded(
        child: new Text(title,
          overflow: TextOverflow.ellipsis,
          style: new TextStyle(fontSize: 16.0),
        )
      )
    );
    // TODO: implement build
    return new WebviewScaffold(
      url: widget.post['url'],
      key: scaffoldKey,
      withZoom: true,
      withLocalStorage: true,
      withJavascript: true,
      appBar: new AppBar(
        backgroundColor: Colors.grey[200],
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: titleContent,
        ),
        actions: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(4.0),
            child: new IconButton(
              icon: new Icon(Icons.refresh),
              onPressed: (){

              },
            ),
          ),
          new Padding(
            padding: const EdgeInsets.all(4.0),
            child: new IconButton(
                icon: new Icon(Icons.share),
                onPressed: (){
                  SharePage.buildShareBottomPop(context);
                }
            ),
          ),
        ],
      ),
    );
  }
}