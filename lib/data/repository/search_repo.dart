import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_ui_kit/data/model/response/wordpress_product_model.dart';
import 'package:sixvalley_ui_kit/utill/app_constants.dart';
import 'package:sixvalley_ui_kit/utill/decode_json.dart';

final getIt = GetIt.instance;

class SearchRepo {
  final SharedPreferences sharedPreferences;
  SearchRepo({@required this.sharedPreferences});

  Future<List<WordPressProductModel>> getSearchProductList(
      String query, int pageCount) async {
    List<WordPressProductModel> listOfWordPressProductModel = [];
    final urlOfSearch =
        "${AppConstants.SEARCH_PRODUCTS_URI}${query}&${AppConstants.SEARCH_PER_PAGE}$pageCount";
    final data = await DecodeToJson.decodeFromJsonOrUrl(
      url: urlOfSearch,
      callback: get,
    );

    final List products = data["products"];
    print("Json Data of search ${data?.length}");
    products.forEach((element) {
      print("Element Of Serch Repo ${element["in_stock"]}");
      if (element["in_stock"] && element["variations"].isNotEmpty)
        listOfWordPressProductModel
            .add(WordPressProductModel.fromJson(element));
    });
    if (products.isEmpty) {
      return [];
    } else
      return listOfWordPressProductModel;
    /*final f = products.where((element) {
      bool queryMatched;
      print("Products which to matched ${element.name}");
      final str = RegExp(r"^[A-Z]+$").firstMatch(element.name);
      queryMatched = str != null ? true : false;
      */ /*element.name.contains(
          RegExp(r"^[A-Z]+$", caseSensitive: false, multiLine: false));*/ /*
      print("Searching Products found ?? $queryMatched");
      return queryMatched;
    }).toList();
    return f;*/
  }

  // for save home address
  Future<void> saveSearchAddress(String searchAddress) async {
    try {
      List<String> searchKeywordList =
          sharedPreferences.getStringList(AppConstants.SEARCH_ADDRESS);
      if (!searchKeywordList.contains(searchAddress)) {
        searchKeywordList.add(searchAddress);
      }
      await sharedPreferences.setStringList(
          AppConstants.SEARCH_ADDRESS, searchKeywordList);
    } catch (e) {
      throw e;
    }
  }

  List<String> getSearchAddress() {
    return sharedPreferences.getStringList(AppConstants.SEARCH_ADDRESS) ?? [];
  }

  Future<bool> clearSearchAddress() async {
    return sharedPreferences.setStringList(AppConstants.SEARCH_ADDRESS, []);
  }
}

final productList = [
  /* WordPressProductModel(
    realPrice: 7540,
    featured: "yes",
    id: Random().nextInt(100),
    price: 5590,
    rating: 2.5,
    discount: 10,
    categoryType: "PARTY WEAR",
    sizes: ["small", "large", "medium"],
    thumbnail:
        "https://www.exclusiveinn.com/wp-content/uploads/2020/09/ZZS39B.jpg",
    moreImages: [
      "https://www.exclusiveinn.com/wp-content/uploads/2020/09/ZZS39B.jpg",
      "https://www.exclusiveinn.com/wp-content/uploads/2020/09/ZZS39.jpg",
      "https://www.exclusiveinn.com/wp-content/uploads/2020/09/ZZS39A.jpg",
    ],
    short_desc:
        "Exclusive Boutique New Party Wear. The shirt is made crepe georgatte. It has got beautiful hand embroidery on it with crepe georgatte bottom and net dupatta. This dress is available in extra small,small,medium,large and extra large sizes.",
    title: "EXCLUSIVE GRAY AND BLUE PARTY WEAR – ZZS39",
  ),
  WordPressProductModel(
    realPrice: 7540,
    featured: "yes",
    id: Random().nextInt(100),
    price: 5590,
    rating: 2.5,
    discount: 10,
    categoryType: "PARTY WEAR",
    sizes: ["small", "large", "medium"],
    thumbnail:
        "https://www.exclusiveinn.com/wp-content/uploads/2020/09/ZZS39B.jpg",
    moreImages: [
      "https://www.exclusiveinn.com/wp-content/uploads/2020/09/ZZS39B.jpg",
      "https://www.exclusiveinn.com/wp-content/uploads/2020/09/ZZS39.jpg",
      "https://www.exclusiveinn.com/wp-content/uploads/2020/09/ZZS39A.jpg",
    ],
    short_desc:
        "Exclusive Boutique New Party Wear. The shirt is made crepe georgatte. It has got beautiful hand embroidery on it with crepe georgatte bottom and net dupatta. This dress is available in extra small,small,medium,large and extra large sizes.",
    title: "EXCLUSIVE GRAY AND BLUE PARTY WEAR – ZZS39",
  ),
  WordPressProductModel(
    realPrice: 7540,
    featured: "yes",
    id: Random().nextInt(100),
    price: 5590,
    rating: 2.5,
    discount: 10,
    categoryType: "PARTY WEAR",
    sizes: ["small", "large", "medium"],
    thumbnail:
        "https://www.exclusiveinn.com/wp-content/uploads/2020/09/ZZS39B.jpg",
    moreImages: [
      "https://www.exclusiveinn.com/wp-content/uploads/2020/09/ZZS39B.jpg",
      "https://www.exclusiveinn.com/wp-content/uploads/2020/09/ZZS39.jpg",
      "https://www.exclusiveinn.com/wp-content/uploads/2020/09/ZZS39A.jpg",
    ],
    short_desc:
        "Exclusive Boutique New Party Wear. The shirt is made crepe georgatte. It has got beautiful hand embroidery on it with crepe georgatte bottom and net dupatta. This dress is available in extra small,small,medium,large and extra large sizes.",
    title: "EXCLUSIVE GRAY AND BLUE PARTY WEAR – ZZS39",
  ),*/
];
