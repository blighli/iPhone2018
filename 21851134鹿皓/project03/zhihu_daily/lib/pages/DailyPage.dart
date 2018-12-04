import 'package:flutter/material.dart';
import 'DailyListPage.dart';

class DialyPage extends StatefulWidget {
  @override
  _DialyPageState createState() => _DialyPageState();
}

class _DialyPageState extends State<DialyPage> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '知乎日报',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("首页"),
          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.notifications), onPressed: null),
            new PopupMenuButton(itemBuilder: (BuildContext context) {
              List<PopupMenuItem> list = <PopupMenuItem>[
                new PopupMenuItem(child: new Text("夜间模式")),
                new PopupMenuItem(child: new Text("设置选项"))
              ];
              return list;
            })
          ],
        ),
        body: DialyListPage(),
      ),
    );
  }
}
