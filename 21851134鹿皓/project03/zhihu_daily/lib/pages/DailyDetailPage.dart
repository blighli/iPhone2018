import 'package:flutter/material.dart';
import '../api/Api.dart';
import 'dart:convert';
import 'package:zhihu_daily/util/NetUtils.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


class DailyDetailPage extends StatefulWidget {

  int id;

  DailyDetailPage({Key key, this.id}) :super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _DailyDetailPageState(id: this.id);
  }


}

class _DailyDetailPageState extends State<DailyDetailPage> {

  int id;
  var image;
  var title;
  var shareUrl ;


  TextStyle titleStyle = new TextStyle(color: Colors.white, fontSize: 18.0);


  _DailyDetailPageState({Key key, this.id});

  @override
  void initState() {
    super.initState();
    getDetailData();
  }

  @override
  Widget build(BuildContext context) {

    if (shareUrl == null) {
      return new MaterialApp(
        home: new Scaffold(
          appBar: getAppBar(context),
          body: new Center(
            child: new CircularProgressIndicator(),
          ),
        ),
      );
    } else {
      return new WebviewScaffold(
        url: shareUrl,
        appBar: getAppBar(context),
      );
    }

  }

  AppBar getAppBar(BuildContext context){
    return new AppBar(
      leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: (){
          Navigator.of(context).pop("hahah");
          }),
      actions: <Widget>[
        new IconButton(
            icon: new Icon(Icons.share, color: Colors.white,),
            onPressed: null),
        new IconButton(
            icon: new Icon(Icons.favorite, color: Colors.white,),
            onPressed: null),
        new IconButton(
            icon: new Icon(Icons.comment, color: Colors.white,),
            onPressed: null),
        new IconButton(
            icon: new Icon(Icons.favorite, color: Colors.white,),
            onPressed: null),

      ],
    );
  }



  /**
   * 请求详情数据
   */
  void getDetailData() {
    String url = Api.getDetailContent + id.toString();
    print("日报详情url:  $url");

    NetUtils.get(url, (data) {
      if (data != null) {
        Map<String, dynamic> map = json.decode(data);
        var _image = map['image'];
        var _title = map['title'];
        var _share_url = map['share_url'];
        setState(() {
          image = _image;
          title = _title;
          shareUrl = _share_url;
        });
      }
    }, errorCallback: (e) {
      print("请求数据异常$e");
    }
    );
  }

  /**
   * 详情内容
   */
  Widget getContent() {
    if (image == null) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      return new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            getTopImage(),
          ],
        ),
      );
    }
  }

  /**
   * 获取顶部图片标题
   */
  Widget getTopImage() {
    return new Container(
        height: 180.0,
        child: new Stack(
          children: <Widget>[
            new Container(
              foregroundDecoration: new BoxDecoration(
                  image: new DecorationImage(
                      image: new NetworkImage(image),
                      fit: BoxFit.fitWidth
                  )
              ),
            ),
            new Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(
                  bottom: 30.0, left: 10.0, right: 10.0),
              child: new Text(title, style: titleStyle,),

            )
          ],
        )
    );
  }

}