import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gank_flutter/gank/ext/http.dart';
import 'package:gank_flutter/gank/ext/data.dart';
import 'package:gank_flutter/gank/ext/constant.dart' as ext;

class ClassifyList extends StatefulWidget {
  String classifyType;
  bool showTitle = false;

  ClassifyList({Key key, this.classifyType, this.showTitle}) :super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ClassifyListPage();
  }
}

class ClassifyListPage extends State<ClassifyList> {
  var listData;
  var currentPage = 1;
  var listTotalSize = 0;
  var pageSize = 10;
  ScrollController controller = new ScrollController();

  ClassifyListPage() {
    controller.addListener(() {
      var maxScroll = controller.position.maxScrollExtent;
      var pixels = controller.position.pixels;
      if(maxScroll == pixels) {
        currentPage++;
        getNewLists(true);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewLists(false);
  }

  getNewLists(bool isLoadMore) {
    var url = 'http://gank.io/api/data/';
    url += widget.classifyType + '/' + this.pageSize.toString() +'/' + this.currentPage.toString();
    HttpExt.get(url, (data){
      if(data != null) {
        CategoryResponse res = CategoryResponse.fromJson(jsonDecode(data));
        if(!res.error) {
          var list = res.results;
          if(list.length > 0) {
            setState(() {
              if(!isLoadMore) {
                listData = list;
              } else {
                List l = new List();
                l.addAll(listData);
                l.addAll(list);
                listData = l;
              }
            });
          }
        }
      }
    }, (e) {

    });

  }

  Future<Null> pullToRefresh() async {
    currentPage = 1;
    getNewLists(false);
    return null;
  }

  @override
  Widget build(BuildContext context) {
//    if(listData == null) {
//      return new Center(
//        child: new CupertinoActivityIndicator(),
//      );
//    } else {
//      Widget listView = buildListView(context, listData);
//      return new RefreshIndicator(
//          child: listView,
//          onRefresh: pullToRefresh
//      );
//    }
    if(widget.showTitle) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.classifyType),
          backgroundColor: Colors.grey[200],
        ),
        body: buildList(context),
      );
    } else {
      return new Scaffold(
        body: buildList(context),
      );
    }
  }

  Widget buildList(BuildContext context) {
    if(listData == null) {
      return new Center(
        child: new CupertinoActivityIndicator(),
      );
    } else {
      Widget listView = buildListView(context, listData);
      return new RefreshIndicator(
          child: listView,
          onRefresh: pullToRefresh
      );
    }
  }

  Widget buildListView(BuildContext context, List results) {
    switch(results.length) {
      case 1:
        return new Center(
          child: new Card(
            elevation: 16.0,
            child: new Text('暂无数据'),
          ),
        );

      default:
        return new ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(2.0),
          controller: controller,
          itemCount: results == null ? 0 : results.length,
          itemBuilder: (context, i) {
            return ext.buildRow(context, results[i]);
          }
        );
    }
  }
}
