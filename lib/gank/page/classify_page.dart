import 'package:flutter/material.dart';
import 'package:gank_flutter/gank/net/classify_list.dart';

class ClassifyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ClassifyPageState();
  }
}

class ClassifyPageState extends State<ClassifyPage> with SingleTickerProviderStateMixin {

  TabController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new TabController(length: allPages.length, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('分类阅读'),
        backgroundColor: Colors.grey[100],
        bottom: new TabBar(
          controller: controller,
          indicatorColor: Theme.of(context).primaryColor,
          isScrollable: true,
          tabs: allPages.map((Page page){
            return new Tab(text: page.text,);
          }).toList(),
        ),
        actions: <Widget>[
//          new Padding(padding: const EdgeInsets.all(4.0),
//            child: new IconButton(
//              icon: new Icon(Icons.reorder),
//              onPressed: () {
//              },),
//          ),
          new Padding(padding: const EdgeInsets.all(4.0),
            child: new IconButton(
              icon: new Icon(Icons.search),
              onPressed: () {

              },),),
        ],
      ),
      body: new TabBarView(
        controller: controller,
        children: allPages.map((Page page) {
          return page.classifyList;
        }).toList(),
      ),
    );
  }
}

class Page {

  Page({this.icon, this.text, this.classifyList});

  final IconData icon;
  final String text;
  final ClassifyList classifyList;
}

final List<Page> allPages = <Page> [
  new Page(text: 'All', classifyList: new ClassifyList(classifyType: ('all'), showTitle: false,)),
  new Page(text: 'iOS', classifyList: new ClassifyList(classifyType: ('iOS'), showTitle: false,)),
  new Page(text: 'Android', classifyList: new ClassifyList(classifyType: ('Android'), showTitle: false,)),
  new Page(text: '瞎推荐', classifyList: new ClassifyList(classifyType: ('瞎推荐'), showTitle: false,)),
  new Page(text: '前端', classifyList: new ClassifyList(classifyType: ('前端'), showTitle: false,)),
  new Page(text: '拓展资源', classifyList: new ClassifyList(classifyType: ('拓展资源'), showTitle: false,)),
  new Page(text: 'App', classifyList: new ClassifyList(classifyType: ('App'), showTitle: false,)),
  new Page(text: '休息视频', classifyList: new ClassifyList(classifyType: ('休息视频'), showTitle: false,)),
  new Page(text: '福利', classifyList: new ClassifyList(classifyType: ('福利'), showTitle: false,)),

];