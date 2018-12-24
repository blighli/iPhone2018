import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'screen_item.dart';
import 'utils/location.dart';
import 'utils/notification.dart';
import 'utils/calculator.dart';
import 'Reminder.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Reminder> _reminderItems = <Reminder>[
    Reminder(
        title: '学校蜂巢快递柜',
        desc: '取快递，取号码：0180',
        latitude: 29.8912481909,
        longitude: 121.6399598122,
        distance: 500,
        toggle: false),
    Reminder(
        title: '永辉超市',
        desc: '买纸巾、洗发水',
        latitude: 29.8923364733,
        longitude: 121.6553878784,
        distance: 500,
        toggle: true),
    Reminder(
        title: '实验室',
        desc: '拿一下电脑充电器',
        latitude: 29.8902203577,
        longitude: 121.6401636600,
        distance: 500,
        toggle: true),
    Reminder(
        title: '寝室楼下',
        desc: '看一下水费和电费要不要交',
        latitude: 29.8909877455,
        longitude: 121.6358828545,
        distance: 500, toggle: false)
  ];
  var _currentLatitude = -1.0;
  var _currentLongitude = -1.0;

  @override
  void initState() {
    super.initState();

    MyLocation.initLocation(this.onLocation);
    initReminderItems();
  }

  // 初始化 Reminders
  void initReminderItems() async {
    // var items = await Reminder.readList();

    // setState(() {
    //   _reminderItems = items;
    // });
  }

  // 监听 location 变化
  void onLocation(location) {
    var latitude = location.coords.latitude;
    var longitude = location.coords.longitude;

    _reminderItems.forEach((item) {
      var currentDistance = MyCalculator.getDistance(
          item.latitude, item.longitude, latitude, longitude);
      if (currentDistance < item.distance && item.toggle) {
        print('到达${item.title}附近');
        MyNotification.show('到达${item.title}附近', '${item.desc}', '');
      }
    });

    setState(() {
      _currentLatitude = latitude;
      _currentLongitude = longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Location Reminder'),
        trailing: CupertinoButton(
          padding: EdgeInsets.all(0),
          child: Icon(Icons.add),
          onPressed: () {
            onButtonPressed();
          },
        ),
      ),
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 80, 0, 0),
        child: _buildReminders(),
      ),
    );
  }

  Widget _buildReminders() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _reminderItems.length,
        itemBuilder: (context, i) {
          return Column(children: <Widget>[
            _buildRow(_reminderItems[i], i),
            Divider(),
          ]);
        });
  }

  Widget _buildRow(item, index) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    CupertinoButton(
                      padding: EdgeInsets.all(0),
                      minSize: 22,
                      pressedOpacity: 0.5,
                      child: Text(
                        item.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {
                        onButtonPressed(reminder: item, index: index);
                      },
                    ),
                    Text(
                      item.toggle
                          ? " ${MyCalculator.getDistance(item.latitude, item.longitude, _currentLatitude, _currentLongitude)}m"
                          : "",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
              Text(
                item.desc,
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
        CupertinoSwitch(
            onChanged: (state) {
              setState(() {
                item.toggle = state;
              });
            },
            value: item.toggle)
      ],
    );
  }

  onButtonPressed({Reminder reminder, int index}) async {
    final result = await Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) =>
                ItemAddScreen(reminder: reminder, index: index)));

    if (result != null) {
      String action = result['action'];
      setState(() {
        switch (action) {
          case 'delete':
            _reminderItems.removeAt(result["index"]);
            break;
          case 'add':
            _reminderItems.add(result["reminder"]);
            break;
        }

        Reminder.saveList(_reminderItems);
      });
    }
  }
}
