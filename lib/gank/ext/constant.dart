import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gank_flutter/gank/ext/data.dart';
import 'package:gank_flutter/gank/page/web_page.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:io';

final Map<String, Color> tagColors = {
  'Android': const Color(0xff94859c),
  'iOS': const Color(0xff5b6356),
  '前端': const Color(0xffca8269),
  '瞎推荐': const Color(0xff9d3d3f),
  '拓展资源': const Color(0xffe4dc8b),
  '福利': const Color(0xffe5acbf),
  'App': const Color(0xff772f09),
  '休息视频': const Color(0xffa6c7b2),
};

Widget buildExceptionIndicator(String message) {
  return new Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      new Align(
        alignment: Alignment.center,
        child: new Image.asset("images/data_empty.png"),
      ),
      new Align(
        alignment: Alignment.center,
        child: new Text(message, style: const TextStyle(color: Colors.grey),),
      )
    ],
  );
}

String getTimestampString(DateTime date) {
  DateTime curDate = new DateTime.now();
  Duration diff = curDate.difference(date);
  if (diff.inDays > 0) {
    return diff.inDays.toString() + "天前";
  } else if (diff.inHours > 0) {
    return diff.inHours.toString() + "小时前";
  } else if (diff.inMinutes > 0) {
    return diff.inMinutes.toString() + "分钟前";
  } else if (diff.inSeconds > 0) {
    return "刚刚";
  }
  return date.toString();
}

Widget buildLoadingIndicator() {
  return new Center(
    child: new CupertinoActivityIndicator(),
  );
}


Widget buildDailyListView(BuildContext context, AsyncSnapshot snapshot) {
  Map<String, dynamic> value;
  List content = new List();
  List title = new List();

  value = jsonDecode(snapshot.data);
  DailyResponse res = DailyResponse.fromJson(value);

  if(res.error) {
    return buildExceptionIndicator('网络请求错误');
  } else {
    if(res.category.length == 0) {
      return buildExceptionIndicator('没有对应的数据');
    } else {
      //这里多做一层循环，主要是为了将福利展示在最前面
      res.category.forEach((row) {
        if (row == '福利') {
          title.insert(0, row);
        } else {
          title.add(row);
        }
      });
      title.forEach((title) {
        content.addAll(res.results[title]);
      });
      return buildListViewBuilder(context, content);
    }
  }
}

Widget buildListViewBuilder(context, List content) {
  return new ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(2.0),
      itemCount: content == null ? 0 : content.length,
      itemBuilder: (context, i) {
        return buildRow(context, content[i]);
      },
  );
}

Widget buildRow(context, one) {
  final ThemeData theme = Theme.of(context);
  final TextStyle titleStyle = theme.textTheme.headline.copyWith(color: Colors.white);

  PostData postData = PostData.fromJson(one);
  if(postData.type == '福利') {
    return new InkWell(
      onTap: () {
        Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext context) {
              return new WebPage(postData.toJson());
            })
        );
      },
      child: new Card(
        margin: new EdgeInsets.all(2.0),
        child: new Padding(
          padding: new EdgeInsets.all(8.0),
          child: new SizedBox(
            height: 300.0,
            child: new Stack(
              children: <Widget>[
                new Positioned.fill(
                    child: new FadeInImage.assetNetwork(
                      placeholder: 'images/data_empty.png',
                      image: postData.url,
                      fit: BoxFit.cover,
                      repeat: ImageRepeat.repeat,
                    )
                ),
                new Positioned(
                    bottom: 6.0,
                    left: 6.0,
                    right: 6.0,
                    child: new FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.bottomLeft,
                      child: new Text(postData.desc,style: titleStyle,),
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  } else {
    return new InkWell(
      onTap: () {
        Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext context) {
              return new WebPage(postData.toJson());
            })
        );
      },
      child: new Card(
        margin: new EdgeInsets.all(2.0),
        child: new Padding(
          padding: new EdgeInsets.all(8.0),
          child: new Column(
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.fromLTRB(2.0, 4.0, 2.0, 4.0),
                child: new Align(
                  alignment: Alignment.centerLeft,
                  child: new Text(postData.desc,
                      style: new TextStyle(
                          fontSize: 16.0,
                          color: Colors.black
                      )
                  ),
                ),
              ),
              new Container(
                margin: new EdgeInsets.fromLTRB(2.0, 4.0, 2.0, 4.0),
                child: new Align(
                  alignment: Alignment.centerLeft,
                  child: new Text(postData.who.toString(),
                    style: new TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              new Row(
                children: <Widget>[
                  new Align(
                    alignment: Alignment.centerLeft,
                    child: new Card(
                      color: tagColors[postData.type],
                      child: new Padding(
                        padding: new EdgeInsets.all(2.0),
                        child: new Text(one['type'],
                          style: new TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  new Expanded(
                      child: new Align(
                        alignment: Alignment.centerRight,
                        child: new Text(getTimestampString(DateTime.parse(postData.publishedAt)),
                          style: new TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey,
                          ),
                        ),
                      )
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}