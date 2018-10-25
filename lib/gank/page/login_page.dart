import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gank_flutter/gank/ext/share.dart';
//import 'package:flutter_app/gank/ext/http.dart';
import 'package:http/http.dart' as Http;

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new LoginPageState();
  }
}


class LoginPageState extends State<LoginPage> {
  GlobalKey<ScaffoldState> regisKey = new GlobalKey();
  String phoneNum = '';
  String password = '';

  void login() async {
    var headers = {
      'X-Bmob-Application-Id':'3cffba5dd27a414d9ff6485315cca823',
      'X-Bmob-REST-API-Key':'3eeb7549f2c675897b4e766fa0235940'
    };
    var body;
    body = {
      'name':'unknown',
      'phone': phoneNum,
      'password': password
    };

//    HttpExt.postHeader('https://api2.bmob.cn/1/classes/member',(data){
//
//    });
    Http.Response response = await Http.post('https://api2.bmob.cn/1/classes/member',headers: headers,body: body);
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    var node = new FocusNode();
    var pwdNode = new FocusNode();
    // TODO: implement build
    return new Material(
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text('Github账号登录'),
          backgroundColor: Colors.grey[100],
          actions: <Widget>[
            new InkWell(
              child: new Padding(
                padding: EdgeInsets.all(18.0),
                child: new Text('其他登录方式'),
              ),
              onTap: () {
                SharePage.buildShareBottomPop(context);
              },
            )
          ],
        ),
        body: new Column(
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 50.0, top: 50.0, bottom: 50.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Image.asset(
                    'images/logo.png',
                    width: 60.0,
                    height: 60.0,
                  ),
                ],
              ),
            ),
            new Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 40.0),
              child: new TextField(
                onChanged: (str){
                  phoneNum = str;
                  setState(() {

                  });
                },
                decoration: new InputDecoration(
                  hintText: '请输入用户名/邮箱地址',
                  labelText: '账号',
                  hintStyle: new TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  )
                ),
                maxLength: 11,
                maxLines: 1,
                keyboardType: TextInputType.phone,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly,
                ],
                onSubmitted: (text) {
                  FocusScope.of(context).reparentIfNeeded(node);
                },
              ),
            ),
            new Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 40.0),
              child: new Stack(
                children: <Widget>[
                  new TextField(
                    onChanged: (str){
                      password = str;
                      setState(() {

                      });
                    },
                    decoration: new InputDecoration(
                      hintText: '请输入短信验证码',
                      labelText: '密码',
                      hintStyle: new TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                      )
                    ),
                    maxLength: 6,
                    maxLines: 1,
                    keyboardType: TextInputType.phone,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                    onSubmitted: (text) {
                      FocusScope.of(context).reparentIfNeeded(node);
                    },
                  ),
                ],
              ),
            ),
            new Padding(
              padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
              child: new RaisedButton(
                onPressed: () {
                  login();
                },
                padding: new EdgeInsets.fromLTRB(130.0, 10.0, 130.0, 10.0),
                color: Colors.blue,
                textColor: Colors.white,
                disabledColor: Colors.blue[100],
                child: new Text(
                  '登 录',
                  style: new TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
