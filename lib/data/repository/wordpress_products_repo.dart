import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_ui_kit/data/model/response/wordpress_product_model.dart';
import 'package:sixvalley_ui_kit/utill/app_constants.dart';
import 'package:sixvalley_ui_kit/utill/decode_json.dart';
import 'package:http/http.dart';
class WordPressProductRepo {
  final SharedPreferences perfs;

  WordPressProductRepo(this.perfs);

  //Feature Products Fetching
  Future featuredProducts() async {
    print("Feature PRoducts URL ${AppConstants.WP_FEATURE_PRODUCTS_URI}");
    String featureProductsBody;
    if (perfs.containsKey(AppConstants.FEATURED_PRODUCTS)) {
      featureProductsBody = perfs.get(AppConstants.FEATURED_PRODUCTS);
      print("Products being fetched from LocalStorage $featureProductsBody");
    }
    final data = await DecodeToJson.decodeFromJsonOrUrl(
      //body: featureProductsBody,
      url: AppConstants.WP_FEATURE_PRODUCTS_URI,
      //key: AppConstants.FEATURED_PRODUCTS,
      callback: get,
    );
    if (data != null)
      return data["products"];
    else
      return [];
  }

  //Total Number of Products Fetching
  Future<int> getTotalCategoryCount(String slug) async {
    /*final isExists = perfs.containsKey(AppConstants.CATEGORY_COUNT);
    String body;
    if (isExists) {
      body = perfs.getString(AppConstants.CATEGORY_COUNT);
    }*/
    try {
      final data = await DecodeToJson.decodeFromJsonOrUrl<Map<String, dynamic>>(
        //body: body,
        key: AppConstants.CATEGORY_COUNT,
        url: "${AppConstants.CATEGORY_COUNT_URI}$slug",
        callback: get,
      );
      return data["count"];
    } catch (error) {
      print("Client IO Excetion thrown");
    }
  }

  Future<List<WordPressProductModel>> getRandomProducts(int pageCount) async {
    List<WordPressProductModel> wpModel = [];
    String body;
    final product = await DecodeToJson.decodeFromJsonOrUrl(
      //body: body,
      url: "https://www.exclusiveinn.com/wc-api/v3/products?page=$pageCount",
      callback: get,
    );
    print("Product from Map $product");
    (product["products"] as List).forEach((element) {
      print("Elements are ${element["variations"].length > 0}");
      if (element["variations"].length > 0 && element["in_stock"])
        wpModel.add(WordPressProductModel.fromJson(element));
    });
    return wpModel;
  }

  Future iniDetailPage(int productID) async {
    final response = await get("${AppConstants.PRODUCTS_BY_ID_URI}${productID}", headers: {HttpHeaders.authorizationHeader: AppConstants.JWT_ADMIN_TOKEN});
    final product =  jsonDecode(response.body);
    print("Product from Map $product");
    return WordPressProductModel.fromJson(product);
  }

  //init Brand and Category Products
  Future<List<dynamic>> initBrandAndCategoryProducts(
      [int pageCount = 1, String slug]) async {
    final String PER_PAGE_PRODUCTS =
        "https://www.exclusiveinn.com/wc-api/v3/products?filter[category]=${slug}&page=${pageCount}";
    String body;

    if (perfs.containsKey("$slug$pageCount")) {
      body = perfs.getString("$slug$pageCount");
      print("I have to see items $body");
    }
    final products = await DecodeToJson.decodeFromJsonOrUrl(
        // body: body,
        // key: "$slug$pageCount",
        url: PER_PAGE_PRODUCTS,
        callback: get);
    print("Per page Prducts: ${products["products"].length}");
    return products["products"];
    //return [];
  }

  /* getRandomProducts() {
    DecodeToJson.decodeFromJsonOrUrl(
      callback: get,
      url:
    )
  }*/


  Future<List<WordPressProductModel>> getRelatedProducts(List listRelatedItems) async {
    String editedUrl = "${AppConstants.RELATED_PRODUCTS_BY_ID_URI}";
    for (int i = 0; i < listRelatedItems.length; i++) {
      if(i == listRelatedItems.length-1)
        editedUrl += "${listRelatedItems[i]}";
      else
        editedUrl += "${listRelatedItems[i]},";
    }
  print("${editedUrl}");
    final response = await get(editedUrl, headers: {HttpHeaders.authorizationHeader: AppConstants.JWT_ADMIN_TOKEN, HttpHeaders.contentTypeHeader: AppConstants.JSON_CONTENT_TYPE})
        .timeout(AppConstants.TIMED_OUT_20, onTimeout: () {print("Timed Out");})
        .catchError((error) {
          print("Eror Occured");
    });
    if(response != null && response.statusCode == 200) {
      final relatedItems = jsonDecode(response.body);
      final items = relatedItems as List;
      final convertedData = items.map((e) => WordPressProductModel.fromJson(e)).toList();
      return convertedData;
    }else
      return null;

  }


  //Decoding FeaturePrducts
  Future<T> decodeFromJsonOrUrl<T>({
    key: AppConstants.FEATURED_PRODUCTS,
    String body,
    String url,
  }) async {
    T data;
    if (body != null && body.isNotEmpty) {
      data = await jsonDecode(body);
      print("Feature $body -------");
    } else {
      if (url.isNotEmpty && url != null) {
        final response = await get(url, headers: AppConstants.WP_AUTH_HEADER);
        print("URL Response ${response.body}");
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
