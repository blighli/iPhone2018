import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'screen_home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'LocationReminder',
      home: MyHomePage(title: 'Location Reminder'),
    );
  }
}
