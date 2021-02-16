import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_ui_kit/data/model/response/category.dart';
import 'package:sixvalley_ui_kit/data/model/response/wordpress_menu_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/wordpresss_main_nav.dart';
import 'package:sixvalley_ui_kit/utill/app_constants.dart';
import 'package:sixvalley_ui_kit/utill/decode_json.dart';

class CategoryRepo {
  final WordPressMainMenuRepo wordPressMainMenuRepo;
  final SharedPreferences preferences;
  CategoryRepo({this.wordPressMainMenuRepo, this.preferences});
  List<Category> allCategory = [];
  //final wooCommerceRepo = WooCommerceRepo().initWC();
  //WordPressMainMenuRepo _wordPressMainMenuRepo = WordPressMainMenuRepo();

  Future<List<Category>> getCategoryList() async {
    final List<Category> matchedCategory = [];
    final List<Category> customCategories = [];
    final List<WordPressMenuItemModel> listOfItems = [];
    final WordPressMenuModel menuItems =
        await wordPressMainMenuRepo.fetchMenus();
    print("All Menus ${menuItems.items.length}");
    final categories = await fetchCategories();
    allCategory = categories;
    menuItems.items.forEach((element) {
      listOfItems.add(WordPressMenuItemModel.fromJson(element));
    });
    for (int i = 0; i < listOfItems.length; i++) {
      Category l;
      final slug =
          listOfItems[i].url.split(AppConstants.PRODUCT_CATEGORY_SLUG).last;
      final sl = slug.substring(0, slug.length - 1);
      try {
        l = categories.firstWhere((element) {
          bool isSlugMatched = (element.slug == sl);
          return isSlugMatched;
        });
        if (l.slug == sl) {
          matchedCategory.add(Category(
            name: listOfItems[i].title,
            slug: l.slug,
            id: l.id,
            categoryName: l.categoryName,
            icon: l.icon,
            count: l.count,
            parentId: l.parentId,
            updatedAt: l.updatedAt,
            subCategories: l.subCategories,
            createdAt: l.createdAt,
            position: l.position,
          ));
        }
      } catch (error) {
        print("Error not added $error");
      }
    }

    for (Category category in matchedCategory) {
      if (category.icon.isNotEmpty) {
        customCategories.add(category);
      }
    }

    return customCategories;
  }

  Future<List<Category>> fetchCategories() async {
    final List<Category> allCategories = [];
    String categoryBody;
    if (preferences.containsKey(AppConstants.WP_CATEGORY_KEY)) {
      categoryBody = preferences.getString(AppConstants.WP_CATEGORY_KEY);
    }
    print("CCCC ${categoryBody}");
    final categories = await DecodeToJson.decodeFromJsonOrUrl(
      //body: categoryBody,
      url: AppConstants.WP_ALL_CATEGORIES,
      callback: get,
      // key: AppConstants.WP_CATEGORY_KEY);
    );
    if (categories["product_categories"] != null &&
        categories["product_categories"] is List) {
      final listOfCategories = categories["product_categories"];
      listOfCategories.forEach((category) {
        allCategories.add(Category.fromJson(category));
        print("Category name ${category["image"]}");
      });
    }
    return allCategories;
    /*final List<Category> _categories = [];
    final response = await get(AppConstants.WP_CATEGORY_URI,
        headers: AppConstants.WP_AUTH_HEADER);
    if (response.statusCode == 200) {
      final jsonCategory = await jsonDecode(response.body);
      final listOfCategories = jsonCategory["product_categories"];
      listOfCategories.forEach((category) {
        _categories.add(Category.fromJson(category));
        print("Category name ${category["name"]}");
      });
      print("Length of Category ${_categories.length}");
      return _categories;
    } else
      throw AssertionError("Fetching Category Error");
     */
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
          await preferences.setString(key, body);
          data = await jsonDecode(body);
        }
      } else
        print("URL is empty");
    }
    return data;
  }
}
