import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'Reminder.dart';

class ItemAddScreen extends StatelessWidget {
  final Reminder reminder;
  final int index;
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Reminder'),
        trailing: index != null
            ? CupertinoButton(
                padding: EdgeInsets.all(0),
                child: Text(
                  '删除',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  // 删除
                  print('删除 index 为 $index 的 Reminder: ${reminder.title}');

                  Navigator.pop(context, {"action": "delete", "index": index});
                },
              )
            : null,
      ),
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 100, 0, 0),
        child: MyCustomForm(reminder, index),
      ),
    );
  }

  ItemAddScreen({Key key, this.reminder, this.index}) : super(key: key);
}

class MyCustomForm extends StatefulWidget {
  final Reminder reminder;
  final int index;

  @override
  MyCustomFormState createState() {
    return MyCustomFormState(reminder, index);
  }

  MyCustomForm(this.reminder, this.index);
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  var _currentLocation = <String, double>{};

  Reminder _reminder;
  int _index;

  bool _editMode = false;

  MyCustomFormState(Reminder reminder, this._index) {
    _reminder = reminder == null ? new Reminder() : reminder;
    if (_index != null) {
      _editMode = true;
    }
  }

  initLocation() async {
    var location = new Location();
    var currentLocation = await location.getLocation();

    if (_editMode == false) {
      setState(() {
        _currentLocation = currentLocation;
        _reminder.latitude = _currentLocation["latitude"];
        _reminder.longitude = _currentLocation["longitude"];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              children: <Widget>[
                Text(
                  '地点名称',
                ),
                Divider(
                  height: 5,
                  indent: 2000,
                ),
                CupertinoTextField(
                  placeholder: '如寝室、教学楼...',
                  controller: TextEditingController.fromValue(TextEditingValue(
                    text: _reminder.title,
                  )),
                  onChanged: (text) {
                    _reminder.title = text;
                  },
                ),
                Divider(
                  height: 10,
                  indent: 2000,
                ),
                Text('提醒事项'),
                Divider(
                  height: 5,
                  indent: 2000,
                ),
                CupertinoTextField(
                  placeholder: '如拿钥匙、拿书...',
                  controller: TextEditingController.fromValue(TextEditingValue(
                    text: _reminder.desc,
                  )),
                  onChanged: (text) {
                    _reminder.desc = text;
                  },
                ),
                Divider(
                  height: 10,
                  indent: 2000,
                ),
                Text('触发距离'),
                Divider(
                  height: 5,
                  indent: 2000,
                ),
                CupertinoTextField(
                  placeholder: '当在距离该地方多远时进行提醒，默认为500(m)',
                  controller: TextEditingController.fromValue(TextEditingValue(
                    text: "${_reminder.distance}",
                  )),
                  onChanged: (text) {
                    _reminder.distance = int.parse(text);
                  },
                  keyboardType: TextInputType.number,
                ),
                Divider(
                  height: 10,
                  indent: 2000,
                ),
                Text('当前坐标'),
                CupertinoTextField(
                  prefix: Text(' 纬度：'),
                  placeholder: "${_reminder.latitude}",
                  controller: TextEditingController.fromValue(TextEditingValue(
                    text: "${_reminder.latitude}",
                  )),
                  onChanged: (text) {
                    _reminder.latitude = double.parse(text);
                  },
                ),
                CupertinoTextField(
                  prefix: Text(' 经度：'),
                  placeholder: "${_reminder.longitude}",
                  controller: TextEditingController.fromValue(TextEditingValue(
                    text: "${_reminder.longitude}",
                  )),
                  onChanged: (text) {
                    _reminder.longitude = double.parse(text);
                  },
                ),
              ],
            ),
          ),
          Center(
            child: _index == null
                ? CupertinoButton(
                    onPressed: () {
                      Navigator.pop(context, {
                        "action": "add",
                        "reminder": new Reminder(
                            title: _reminder.title,
                            desc: _reminder.desc,
                            latitude: _reminder.latitude,
                            longitude: _reminder.longitude,
                            distance: _reminder.distance,
                            toggle: _reminder.toggle)
                      });
                    },
                    child: Text('完成'),
                  )
                : null,
          ),
        ],
      ),
    );
  }
}
