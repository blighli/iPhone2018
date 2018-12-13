import 'package:http/http.dart' as http;

class NetUtils {
  static void get(String url, Function callback, {Map<String, String> params, Function errorCallback}) async {
    if (params != null && params.isNotEmpty) {
      StringBuffer sb = new StringBuffer("?");
      params.forEach((k,v) {
        sb.write("$k=$v&");
      });
      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      url += paramStr;
    }

    try {
      http.Response response = await http.get(url);
      if (callback != null) {
        callback(response.body);
      }
    } catch (exception) {
      if (errorCallback != null) {
        errorCallback(exception);
      }
    }
  }

  static void post(String url, Function callback, {Map<String, String> params, Function errorCallback}) async {
    try {
      http.Response response = await http.post(url, body: params);
      if (callback != null) {
        callback(response.body);
      }
    } catch (exception) {
      if (errorCallback != null) {
        errorCallback(exception);
      }
    }
  }
}