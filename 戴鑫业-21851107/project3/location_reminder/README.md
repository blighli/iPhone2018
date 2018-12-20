# Location Reminder
原 Repository 地址 [@daixinye - location_reminder](https://github.com/daixinye/zjucst/tree/master/ios-development/flutter/location_reminder)

一个基于 [Flutter](https://flutter.io/) 开发的空间提醒 iOS App。

## 功能

添加空间提醒，可设置「地点」与「提醒事项」，当用户与地点小于预设的「提醒距离」时，发出通知提醒用户。

支持对提醒的添加、删除、修改和开关。

## 实现效果

![](http://img.daixinye.com/20181220202847.png?imageView2/2/w/400)
![](http://img.daixinye.com/20181220202210.png?imageView2/2/w/400)

![](http://img.daixinye.com/20181220203058.png?imageView2/2/w/400)
![](http://img.daixinye.com/20181220203118.png?imageView2/2/w/400)

## 实现思路

Location 改变时，遍历 Reminder，若有 Reminder 符合条件则进行本地通知。

### 基本类
- Reminder，提醒类，含title、desc、latitude、longitude等成员变量
### 工具类
- file，用于保存、读取 Reminders，数据持久化
- calculator，根据经纬度计算距离
- location，监听location变化，添加callback
- notification，本地通知
### 界面
- screen_home，Reminder 列表页
- screen_item，Reminder 详细页

## 已知缺陷
- 地点选择目前仅支持手动输入经纬度，新建时默认填充当前位置的经纬度
- 同时达到多个提醒地点时只有一条通知

## Packages
- [package:location](https://pub.dartlang.org/packages/location)
- [package:flutter_background_geolocation](https://pub.dartlang.org/packages/flutter_background_geolocation)
- [package:flutter_local_notifications](https://pub.dartlang.org/packages/flutter_local_notifications)
- [package:path_provider](https://pub.dartlang.org/packages/path_provider)

## 问题及解决方案
- [homebrew 更新过慢](https://blog.csdn.net/Jimu_Stormrage/article/details/81564158)
- [flutter package get 过慢](https://flutter.io/community/china#configuring-flutter-to-use-a-mirror-site)
- [Waiting for another flutter command to release the startup lock... 的解决方案](https://github.com/flutter/flutter/issues/17422)

## 参考文档
- [Dart](https://www.dartlang.org/)
- [Flutter](https://flutter.io/)
- [《Flutter 实战》](https://book.flutterchina.club/)
- [Flutter 中文网](https://flutterchina.club/)