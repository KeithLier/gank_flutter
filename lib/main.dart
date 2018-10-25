import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:gank_flutter/gank/page/gank.dart';

final ThemeData kIOSTheme = new ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.black,
  primaryColorBrightness: Brightness.light,
);

final ThemeData kAndroidTheme = new ThemeData(
  primarySwatch: Colors.purple,
  primaryColor: Colors.black,
//  accentColor: Colors.orangeAccent[400],
  primaryColorBrightness: Brightness.light,
);

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: defaultTargetPlatform == TargetPlatform.iOS
          ? kIOSTheme
          : kIOSTheme,
      home: new GankPage(),
    );
  }
}
