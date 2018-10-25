import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:gank_flutter/gank/net/daily_list.dart';

class DailyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new DailyPageState();
  }
}


class DailyPageState extends State<DailyPage> {
  DateTime selectedDate = new DateTime.now();

  String url = 'https://gank.io/api/today';

  Future<Null> selectDate(BuildContext context) async {
    final DateTime picker = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: new DateTime(2015,1),
        lastDate: new DateTime(2100,1)
    );
    if(picker != null && picker != selectedDate) {
      setState(() {
        selectedDate = picker;
        url = 'https://gank.io/api/day' + '/' + selectedDate.year.toString() + '/' + selectedDate.month.toString() + '/' + selectedDate.day.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('今日干货'),
        backgroundColor: Colors.grey[200],
        actions: <Widget>[
          new Padding(padding: const EdgeInsets.all(4.0),
            child: new IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () {
                  selectDate(context);
                }
            ),
          )
        ],
      ),
      body: new DailyList(
        url: url,
      )
    );
  }
}
