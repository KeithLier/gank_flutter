import 'package:flutter/material.dart';
import 'draw_page.dart';
import 'package:gank_flutter/gank/net/classify_list.dart';
class PersonPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PersonPageState();
  }
}

class PersonPageState extends State<PersonPage> {

  routePageBuilder(BuildContext context, String title) {
    Navigator.of(context).push(
        new MaterialPageRoute(
            builder: (context){
              return new ClassifyList(
                classifyType: title,
                showTitle: true,
              );
            }
        )
    );

//    Navigator.of(context).push(new PageRouteBuilder(
//        opaque: false,
//        pageBuilder: (BuildContext context, _, __) {
//          return new ClassifyList(
//            classifyType: title,
//            showTitle: true,
//          );
//        },
//        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
//          return new FadeTransition(
//            opacity: animation,
//            child: new FadeTransition(
//              opacity: new Tween<double>(begin: 0.5, end: 1.0).animate(animation),
//              child: child,
//            ),
//          );
//        })
//    );
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('我的'),
        backgroundColor: Colors.grey[100],
      ),
      drawer: new Drawer(
        child: new DrawPage(

        ),
      ),
      body: new SingleChildScrollView(
        child: new Container(
          color: new Color(0xFFEBEBEB),
          child: new Column(
            children: <Widget>[
              serviceCard(context),
            ],
          ),
        ),
      )
    );
  }

  Widget serviceCard(BuildContext context) {
    return  new Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 6.0, bottom: 6.0),
      padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
      child: new Column(
        children: <Widget> [
          new Container(
            margin: const EdgeInsets.only(top: 6.0, bottom: 6.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: itemModelsOne.map<Widget>((item){
                return Container(
                  width: MediaQuery.of(context).size.width / 3,
                  child: new FlatButton(
                    onPressed: (){
                      routePageBuilder(context,item.url);
                    },
                    child: new Container(
                      child: new Column(
                        children: <Widget>[
                          new Container(
                            margin: const EdgeInsets.only(bottom: 6.0),
                            child: new CircleAvatar(
                              radius: 20.0,
                              child: new Icon(item.icon, color: Colors.white,),
                              backgroundColor: item.color,
                            ),
                          ),
                          new Container(
                            child: new Text(
                              item.text,
                              style: new TextStyle(
                                color: Colors.black54,
                                fontSize: 14.0
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ),
                );
              }).toList(),
            ),
          ),
          new Container(
            margin: const EdgeInsets.only(top: 6.0, bottom: 6.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: itemModelsTwo.map<Widget>((item){
                return Container(
                  width: MediaQuery.of(context).size.width / 3,
                  child: new FlatButton(
                      onPressed: (){
                        routePageBuilder(context,item.url);
                      },
                      child: new Container(
                        child: new Column(
                          children: <Widget>[
                            new Container(
                              margin: const EdgeInsets.only(bottom: 6.0),
                              child: new CircleAvatar(
                                radius: 20.0,
                                child: new Icon(item.icon, color: Colors.white,),
                                backgroundColor: item.color,
                              ),
                            ),
                            new Container(
                              child: new Text(
                                item.text,
                                style: new TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14.0
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                );
              }).toList(),
            ),
          ),
          new Container(
            margin: const EdgeInsets.only(top: 6.0, bottom: 6.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: itemModelsThree.map<Widget>((item){
                return Container(
                  width: MediaQuery.of(context).size.width / 3,
                  child: new FlatButton(
                      onPressed: (){
                        routePageBuilder(context,item.url);
                      },
                      child: new Container(
                        child: new Column(
                          children: <Widget>[
                            new Container(
                              margin: const EdgeInsets.only(bottom: 6.0),
                              child: new CircleAvatar(
                                radius: 20.0,
                                child: new Icon(item.icon, color: Colors.white,),
                                backgroundColor: item.color,
                              ),
                            ),
                            new Container(
                              child: new Text(
                                item.text,
                                style: new TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14.0
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                );
              }).toList(),
            ),
          ),
        ]
      )

    );
  }
}

class ItemModel {

  ItemModel({this.icon, this.text, this.url, this.color});
  final IconData icon;
  final String text;
  final String url;
  final Color color;
}

final List<ItemModel> itemModelsOne = <ItemModel> [
  new ItemModel(icon: Icons.layers, text: 'All', url: 'all',color: Colors.green),
  new ItemModel(icon: Icons.watch, text: 'iOS', url: 'iOS',color: Colors.blue),
  new ItemModel(icon: Icons.tablet_android, text: 'Android', url: 'Android',color: Colors.indigoAccent),
];

final List<ItemModel> itemModelsTwo = <ItemModel> [
  new ItemModel(icon: Icons.tv, text: '前端', url: '前端', color: Colors.purple),
  new ItemModel(icon: Icons.radio, text: '瞎推荐', url: '瞎推荐', color: Colors.yellow),
  new ItemModel(icon: Icons.wifi_tethering, text: '拓展资源', url: '拓展资源', color: Colors.cyan),
];

final List<ItemModel> itemModelsThree = <ItemModel> [
  new ItemModel(icon: Icons.text_format, text: 'App', url: 'App', color: Colors.brown),
  new ItemModel(icon: Icons.local_movies, text: '休息视频', url: '休息视频', color: Colors.redAccent),
  new ItemModel(icon: Icons.favorite, text: '福利', url: '福利', color: Colors.orange),
];