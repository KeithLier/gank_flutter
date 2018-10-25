import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gank_flutter/gank/ext/constant.dart' as ext;

class DailyList extends StatefulWidget {
  final String url;

  DailyList({Key key, this.url}) :super(key:key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new DailyListState();
  }
}


class DailyListState extends State<DailyList> {

  Future<String> get(String url) async {
    var httpClicent = new HttpClient();
    var req = await httpClicent.getUrl(Uri.parse(url));
    var res = await req.close();
    return await res.transform(utf8.decoder).join();
  }

  Future<Null> loadData() async {
    print('是否进入了');
    await get(widget.url);
    if(!mounted)
      return;

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new RefreshIndicator(
        child: new FutureBuilder(
            future: get(widget.url),
            builder:(BuildContext context, AsyncSnapshot snapshot) {
              switch(snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return ext.buildLoadingIndicator();
                default:
                  if(snapshot.hasError) {
                    return ext.buildExceptionIndicator(snapshot.error);
                  }
                  return ext.buildDailyListView(context, snapshot);
              }
            }
        ),
        onRefresh: loadData
    );
  }
}
