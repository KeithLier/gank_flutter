import 'package:flutter/material.dart';
import 'daily_page.dart';
import 'classify_page.dart';
import 'person_page.dart';

class GankPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GankPageState();
  }
}


class GankPageState extends State<GankPage> {

  final List<BottomNavigationBarItem> listSet =
  [
    new BottomNavigationBarItem(
      icon: new Icon(Icons.home,color: Colors.grey),
      title: new Text('每日干货'),
    ),
    new BottomNavigationBarItem(
      icon: new Icon(Icons.tune,color: Colors.grey),
      title: new Text('分类阅读'),
    ),
    new BottomNavigationBarItem(
      icon: new Icon(Icons.person,color: Colors.grey,),
      title: new Text('我的'),
    ),
  ];

  final List<StatefulWidget> vcSet = [ new DailyPage(),new ClassifyPage(),new PersonPage()];

  int _sindex=0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: new BottomNavigationBar(items: listSet,type: BottomNavigationBarType.fixed,
        onTap: (int index){
          setState(() {
            _sindex = index;
          });
        },
        currentIndex: _sindex,
      ),
      body: vcSet[_sindex],
    );
  }
}
