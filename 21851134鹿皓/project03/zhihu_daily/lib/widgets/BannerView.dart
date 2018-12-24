import 'package:flutter/material.dart';

class BannerView extends StatefulWidget {

  var data;

  BannerView(this.data);

  @override
  _BannerViewState createState() => _BannerViewState(data);
}

class _BannerViewState extends State<BannerView> with SingleTickerProviderStateMixin {

  List data;
  TabController tabController;

  _BannerViewState(this.data);

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    tabController = new TabController(
        length: data == null ? 0 : data.length,
        vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    if (data != null && data.length > 0) {
      for (int i = 0; i < data.length; i++) {
        var item = data[i];
        var image = item["image"];
        var title = item["title"];
        var id = item["id"];
        items.add(new GestureDetector(
          onTap: () {

          },
          child: new Stack(
            children: <Widget>[
              new Image.network(image,
                  width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitWidth),
              new Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.only(
                  bottom: 30.0, left: 15.0, right: 15.0),
                child: Text(title),
              )
            ],
          ),
        ));
        return new Stack(
          children: <Widget>[
            new TabBarView(
              controller: tabController,
              children: items
            )  ,
            new Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(bottom: 10.0),
              child: new TabPageSelector(
                indicatorSize: 5.0,
                color: Colors.grey,
                selectedColor: Colors.white,
                controller: tabController,
              ),
            )
          ],
        );
      }
    }
  }
}
