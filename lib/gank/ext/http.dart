import 'package:http/http.dart' as http;

class HttpExt {
  static void get(String url, Function callback, Function errorCallback) async {
    try {
      http.Response res = await http.get(url);
      if(callback != null) {
        callback(res.body);
      }
    } catch (e) {
      if(errorCallback != null) {
        errorCallback(e);
      }
    }
  }

  static void post(String url, Function callback, {Map<String, String> params, Function errorCallback}) async {
    try {
      http.Response res = await http.post(url, body: params);
      if (callback != null) {
        callback(res.body);
      }
    } catch (e) {
      if (errorCallback != null) {
        errorCallback(e);
      }
    }
  }

  static void postHeader(String url, Function callback, {Map<String, String> header,Map<String, String> params, Function errorCallback}) async {
    try {
      http.Response res = await http.post(url, headers: header, body: params);
      if (callback != null) {
        callback(res.body);
      }
    } catch (e) {
      if (errorCallback != null) {
        errorCallback(e);
      }
    }
  }

}