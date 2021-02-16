import 'dart:convert';

import 'package:http/http.dart';
import 'package:sixvalley_ui_kit/data/model/response/category.dart';
import 'package:sixvalley_ui_kit/data/model/response/wp_product_model.dart';

class WordPressRepo {
  Future<List<Category>> getCategories() async {
    int counter = 0;
    final List<Category> _categories = [];
    final response = await get(
        "https://www.exclusiveinn.com/wp-json/wc/store/products/categories");
    if (response.statusCode == 200) {
      final List jsonData = await jsonDecode(response.body);
      jsonData.forEach((element) {
        counter++;
        if (element["image"] != null && counter > 3) {
          _categories.add(Category(
            id: element["id"],
            name: element["name"],
            icon: element["image"]["thumbnail"],
            subCategories: [],
          ));
        }
      });
    }
    return _categories;
  }

  Future<List<WpProductModel>> getProducts() async {
    final List<WpProductModel> _productList = [];
    final response =
        await get("https://www.exclusiveinn.com/wp-json/wc/store/products/");
    final List jsonData = await jsonDecode(response.body);
    jsonData.forEach((product) {
      _productList.add(WpProductModel(
        id: 37749,
        name: product["name"],
        short_desc: product["short_description"],
        images: product["images"],
      ));
    });
    return _productList;
  }
}
