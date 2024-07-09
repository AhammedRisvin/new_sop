import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../utils/prefferences.dart';

class FoodServerClient {
  static const int _timeout = 180;

  /// Get request

  static Future<List> get(String url) async {
    AppPref.userToken =
        '5dac68d93137d6ff06b582736ac2029a66d0cc1a64a19dce1450b0149ada523cea1377c615cf44c3f521cb2f8748259cd9590f651dc8a26112cf5b8ec0510e49ddcff1fa75b757af836f4356c6e8f4f179652db4a2358eb231b6e6e6dcc54291f3e7411d112c1c0478edd10d8387ecaf252d5f3d3a76fbf666d4effba7c75d1dacae0f56e826b10d31099e5621e50a4c26f56964ce260d728976484e7ffa7ab9dae2f3abc62984631dff61bdc69bd05f';
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "appId": "6639a722e7d6b3a7a20e5070",
      "country": "india",
    };
    if (AppPref.userToken.isNotEmpty) {
      headers["authorization"] = "Bearer ${AppPref.userToken}";
    }

    try {
      var response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: _timeout));
      log("message  ${response.body}");
      return _response(response);
    } on SocketException {
      return [600, "No internet"];
    } catch (e) {
      return [600, e.toString()];
    }
  }

  /// Post request

  static Future<List> post(
    String url, {
    Map<String, dynamic>? data,
    bool post = true,
  }) async {
    AppPref.userToken =
        '5dac68d93137d6ff06b582736ac2029a66d0cc1a64a19dce1450b0149ada523cea1377c615cf44c3f521cb2f8748259cd9590f651dc8a26112cf5b8ec0510e49ddcff1fa75b757af836f4356c6e8f4f179652db4a2358eb231b6e6e6dcc54291f3e7411d112c1c0478edd10d8387ecaf252d5f3d3a76fbf666d4effba7c75d1dacae0f56e826b10d31099e5621e50a4c26f56964ce260d728976484e7ffa7ab9dae2f3abc62984631dff61bdc69bd05f';
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "appId": "6639a722e7d6b3a7a20e5070",
      "country": "india",
    };
    if (AppPref.userToken.isNotEmpty) {
      headers["authorization"] = "Bearer ${AppPref.userToken}";
    }
    log('url::$url');
    log('data::$data');
    try {
      var body = json.encode(data);
      var response = await http
          .post(Uri.parse(url), body: post ? body : null, headers: headers)
          .timeout(const Duration(seconds: _timeout));
      log('body::${response.body}');
      return _response(response);
    } on SocketException {
      return [600, "No internet"];
    } catch (e) {
      return [600, e.toString()];
    }
  }

  /// Put request

  static Future<List> put(
    String url, {
    Map<String, dynamic>? data,
    bool put = false,
  }) async {
    log("message  $data");
    log("url  $url");
    AppPref.userToken =
        '5dac68d93137d6ff06b582736ac2029a66d0cc1a64a19dce1450b0149ada523cea1377c615cf44c3f521cb2f8748259cd9590f651dc8a26112cf5b8ec0510e49ddcff1fa75b757af836f4356c6e8f4f179652db4a2358eb231b6e6e6dcc54291f3e7411d112c1c0478edd10d8387ecaf252d5f3d3a76fbf666d4effba7c75d1dacae0f56e826b10d31099e5621e50a4c26f56964ce260d728976484e7ffa7ab9dae2f3abc62984631dff61bdc69bd05f';
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "appId": "6639a722e7d6b3a7a20e5070",
      "country": "india",
    };
    if (AppPref.userToken.isNotEmpty) {
      headers["authorization"] = "Bearer ${AppPref.userToken}";
    }
    try {
      String? body = json.encode(data);
      var response = await http
          .put(Uri.parse(url), body: put ? null : body, headers: headers)
          .timeout(const Duration(seconds: _timeout));
      log('body::${response.body}');
      return _response(response);
    } on SocketException {
      return [600, "No internet"];
    } catch (e) {
      return [600, e.toString()];
    }
  }

  /// Delete request

  static Future<List> delete(
    String url, {
    Map<String, dynamic>? data,
  }) async {
    AppPref.userToken =
        '5dac68d93137d6ff06b582736ac2029a66d0cc1a64a19dce1450b0149ada523cea1377c615cf44c3f521cb2f8748259cd9590f651dc8a26112cf5b8ec0510e49ddcff1fa75b757af836f4356c6e8f4f179652db4a2358eb231b6e6e6dcc54291f3e7411d112c1c0478edd10d8387ecaf252d5f3d3a76fbf666d4effba7c75d1dacae0f56e826b10d31099e5621e50a4c26f56964ce260d728976484e7ffa7ab9dae2f3abc62984631dff61bdc69bd05f';
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "appId": "6639a722e7d6b3a7a20e5070",
      "country": "india",
    };
    if (AppPref.userToken.isNotEmpty) {
      headers["authorization"] = "Bearer ${AppPref.userToken}";
    }
    String? jsonData = data != null ? json.encode(data) : null;

    var response =
        await http.delete(Uri.parse(url), headers: headers, body: jsonData);
    return await _response(response);
  }

  // ------------------- ERROR HANDLING ------------------- \\

  static Future<List> _response(http.Response response) async {
    switch (response.statusCode) {
      case 200:
        return [response.statusCode, jsonDecode(response.body)];
      case 201:
        return [response.statusCode, jsonDecode(response.body)];
      case 400:
        return [response.statusCode, jsonDecode(response.body)["message"]];
      case 401:
        return [response.statusCode, jsonDecode(response.body)["message"]];
      case 403:
        return [response.statusCode, jsonDecode(response.body)["message"]];
      case 404:
        return [response.statusCode, "You're using unregistered application"];
      case 500:
        return [response.statusCode, jsonDecode(response.body)["message"]];
      case 502:
        return [response.statusCode, "Server Crashed or under maintenance"];
      case 503:
        return [response.statusCode, jsonDecode(response.body)["message"]];
      case 504:
        return [
          response.statusCode,
          {"message": "Request timeout", "code": 504, "status": "Cancelled"}
        ];
      default:
        return [response.statusCode, jsonDecode(response.body)["message"]];
    }
  }
}
