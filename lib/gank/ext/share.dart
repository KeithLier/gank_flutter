import 'package:flutter/material.dart';


class SharePage {

  static buildShareBottomPop(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return new Container(
          height: 200.0,
          color: Colors.white,
          child: new GridView.count(
            crossAxisCount: 4,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            padding: const EdgeInsets.all(4.0),
            children: share_menus.map ((ShareMenu menu){
              return new GestureDetector(
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                      child: new Image.asset(menu.icon,width: 40.0, height: 40.0,),
                    ),
                    new Text(menu.title),
                  ],
                ),
                onTap: () {

                },
              );
            }).toList(),
          ),
        );
      }
    );
  }
}

class ShareMenu {
  final int index;
  final String title;
  final String icon;

  ShareMenu({this.index, this.title, this.icon});
}

List<ShareMenu> share_menus = <ShareMenu> [
   ShareMenu(index: 0, title: '微信', icon: 'images/icon_wx.png'),
   ShareMenu(index: 1, title: '朋友圈', icon: 'images/icon_circle.png'),
   ShareMenu(index: 2, title: 'QQ', icon: 'images/icon_qq.png'),
   ShareMenu(index: 3, title: '新浪微博', icon: 'images/icon_sina.png'),
   ShareMenu(index: 4, title: '短信', icon: 'images/icon_msg.png'),
];