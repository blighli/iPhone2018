import 'package:flutter/material.dart';
import 'package:zhihu_daily/util/NetUtils.dart';
import 'package:zhihu_daily/api/Api.dart';
import 'package:zhihu_daily/widgets/BannerView.dart';
import 'package:zhihu_daily/pages/DailyDetailPage.dart';
import 'dart:convert';

class DialyListPage extends StatefulWidget {

  @override
  _DialyListPageState createState() => _DialyListPageState();

}

class _DialyListPageState extends State<DialyListPage> {

  var top_stories;
  var stories;

  @override
  void initState() {
    super.initState();
    refreshDilyData(true);
  }

  @override
  Widget build(BuildContext context) {
    if (stories == null) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      Widget listView = new ListView.builder(
        itemCount: stories.length + 1,
        itemBuilder: (context, i) => renderRow(i));
      return new RefreshIndicator(child: listView, onRefresh: _pullToRefresh);
    }
  }

  void refreshDilyData(bool isRefresh) {
    NetUtils.get(Api.getLatest, (data) {
      if (data != null) {
        Map<String, dynamic> map = json.decode(data);
        var _top_stiries = map['top_stories'];
        var _stories = map['stories'];
        setState(() {
          if (isRefresh) {
            top_stories = _top_stiries;
            stories = _stories;
          }
        });
      }
    }, errorCallback: (e) {
      print("请求数据异常$e");
    });
  }

  Widget renderRow(int i) {
    if (i == 0) {
      return new Container(
        height: 180.0,
        child: BannerView(top_stories),
      );
    }
    var storie = stories[i - 1];
    var content = new Row(
      children: <Widget>[
        new Expanded(
          flex: 3,
          child: new Padding(
            padding: const EdgeInsets.all(15.0),
            child: new Text(storie["title"]),
          ),
        ),
        new Expanded(
          child: new Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, right: 15.0),
            child: new Center(
              child: Image.network(storie["images"][0]),
            ),
          ),
        )
      ],
    );

    var card = new Card(
      elevation: 2.0,
      margin: const EdgeInsets.only(left: 12.0, top: 6.0, bottom: 6.0, right: 12.0),
      child: content,
    );

    return new InkWell(
      onTap: () async {
        await Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DailyDetailPage(id: storie['id'],)));
      },
      child: card
    );
  }

  Future<Null> _pullToRefresh() {
    refreshDilyData(true);
    return null;
  }
}
