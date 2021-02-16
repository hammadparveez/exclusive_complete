import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_ui_kit/data/model/response/wordpress_menu_model.dart';
import 'package:sixvalley_ui_kit/utill/app_constants.dart';

class WordPressMainMenuRepo {
  final perfs = GetIt.instance.get<SharedPreferences>();
  Future<WordPressMenuModel> fetchMenus() async {
    WordPressMenuModel menuItems;
    String menusBody;
    if (perfs.containsKey(AppConstants.WP_NAV_KEY)) {
      menusBody = perfs.get(AppConstants.WP_NAV_KEY);
    }
    final res = await get(
        "https://www.exclusiveinn.com/wp-json/wp-api-menus/v2/menus/31");
    /*await DecodeToJson.decodeFromJsonOrUrl(

      // body: menusBody,
      url: AppConstants.WP_NAVIGATION_URI,
      callback: get,
      // key: AppConstants.WP_NAV_KEY
    );*/
    final menus = await jsonDecode(res.body);

    if (menus['items'] != null && menus['items'] is List) {
      menuItems = WordPressMenuModel(menus['items']);
    }
    return menuItems;
  }

  Future<T> decodeFromJsonOrUrl<T>({
    String body,
    String url,
    String key,
  }) async {
    T data;
    if (body != null && body.isNotEmpty) {
      data = await jsonDecode(body);
    } else {
      if (url.isNotEmpty && url != null) {
        final response = await get(url, headers: AppConstants.WP_AUTH_HEADER);
        if (response.statusCode == 200 || response.statusCode == 201) {
          final body = response.body;
          await perfs.setString(key, body);
          data = await jsonDecode(body);
        }
      } else
        print("URL is empty");
    }
    return data;
  }
}
