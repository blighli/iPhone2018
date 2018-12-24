import "dart:math";

final EARTH_RADIUS = 6378.137;

class MyCalculator {
  static rad(d) {
    return d * pi / 180.0;
  }

  static getDistance(lat1, lng1, lat2, lng2) {
    var radLat1 = rad(lat1);
    var radLat2 = rad(lat2);
    var a = radLat1 - radLat2;
    var b = rad(lng1) - rad(lng2);

    var s = 2 *
        asin(sqrt(pow(sin(a / 2), 2) +
            cos(radLat1) * cos(radLat2) * pow(sin(b / 2), 2)));
    s = s * EARTH_RADIUS * 1000;
    return s.round();
  }
}
