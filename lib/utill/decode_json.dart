import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_ui_kit/utill/app_constants.dart';

class DecodeToJson {
  static Future<T> decodeFromJsonOrUrl<T>(
      {String body,
      String url,
      key,
      Future<http.Response> callback(url,
          {Map<String, String> headers})}) async {
    final perfs = GetIt.instance.get<SharedPreferences>();
    T data;
    body = null;
    key = null;
    if (body != null && body.isNotEmpty) {
      //data = await jsonDecode(body);
      print("Cache Reading ${key}");
      //print("Feature $body -------");
    } else {
      if (url != null && url.isNotEmpty) {
        final response = await callback(url,
            headers: AppConstants
                .WP_AUTH_HEADER); //http.get(url, headers: AppConstants.WP_AUTH_HEADER);
        //print("URL Response ${response.body}");
        if (response.statusCode == 200 || response.statusCode == 201) {
          final body = response.body;
          //await perfs.setString(key, body);
          data =  jsonDecode(body);
        }
      } else
        print("URL is empty");
    }
    return data;
  }
}
