import 'package:flutter/material.dart';
import 'login_page.dart';

class DrawPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView(
      children: <Widget>[
        new UserAccountsDrawerHeader(
          accountName: new Text('Keith Lee'),
          accountEmail: new Text('keithdeveloper1314@gmail.com'),
          currentAccountPicture: new CircleAvatar(
            backgroundImage: new AssetImage('images/header.jpg'),
          ),
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('images/profile_cover.jpg'),
              fit: BoxFit.cover,
            )
          ),
        ),
        new ListTile(
          title: new Text('干货推荐'),
          leading: new Icon(Icons.invert_colors),
          onTap: () {

          },
        ),
        new ListTile(
          title: new Text('感谢编辑'),
          leading: new Icon(Icons.edit),
          onTap: () {

          },
        ),
        new ListTile(
          title: new Text('版本更新'),
          leading: new Icon(Icons.update),
          onTap: () {

          },
        ),
        new ListTile(
          title: new Text('关于作者'),
          leading: new Icon(Icons.person),
          onTap: () {

          },
        ),
        new ListTile(
          title: new Text('设置'),
          leading: new Icon(Icons.settings),
          onTap: () {

          },
        ),
        new ListTile(
          title: new Text('登出'),
          leading: new Icon(Icons.exit_to_app),
          onTap: () {
            Navigator.of(context).push(
                new MaterialPageRoute(
                    builder: (context){
                      return new LoginPage();
                    }
                )
            );
          },
        ),
      ],
    );
  }
}