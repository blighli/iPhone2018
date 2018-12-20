import 'dart:convert';
import 'utils/file.dart';

class Reminder {
  String title;
  String desc;
  double latitude;
  double longitude;
  int distance;
  bool toggle;

  Reminder(
      {String title,
      String desc,
      double latitude,
      double longitude,
      int distance,
      bool toggle}) {
    this.title = title == null ? "" : title;
    this.desc = desc == null ? "" : desc;
    this.latitude = latitude == null ? 0 : latitude;
    this.longitude = longitude == null ? 0 : longitude;
    this.distance = distance == null ? 500 : distance;
    this.toggle = toggle == null ? false : toggle;
  }

  Object toJsonObj() {
    return {
      "title": title,
      "description": desc,
      "latitude": latitude,
      "longitude": longitude,
      "distance": distance,
      "toggle": toggle
    };
  }

  static void saveList(List<Reminder> list) {
    List jsonList = [];

    list.forEach((item) {
      jsonList.add(item.toJsonObj());
    });

    String jsonString = jsonEncode(jsonList);

    MyFile mf = new MyFile();
    mf.write(jsonString);
  }

  static Future<List<Reminder>> readList() async {
    MyFile mf = new MyFile();
    String contents = await mf.read();
    print(contents);

    List jsonList = jsonDecode(contents);
    List<Reminder> reminderlist = [];

    jsonList.forEach((item) {
      reminderlist.add(Reminder(
          title: item['title'],
          desc: item['desc'],
          latitude: item['latitude'],
          longitude: item['longitude'],
          distance: item['distance'],
          toggle: item['toggle']));
    });

    return reminderlist;
  }
}
