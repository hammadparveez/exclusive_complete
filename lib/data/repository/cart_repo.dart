import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_ui_kit/data/model/response/cart_model.dart';
import 'package:sixvalley_ui_kit/data/shipping_update_model.dart';
import 'package:sixvalley_ui_kit/utill/app_constants.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({@required this.sharedPreferences});
  double totalAmount = 0;
  Future<int> getTotalCartCount() async {
    final bearer =
        "Bearer ${sharedPreferences.get(AppConstants.JWT_TOKEN_KEY)}";
    print("Token Bearer $bearer");
    final response = await get(
        "https://www.exclusiveinn.com/wp-json/wc/store/cart/",
        headers: {HttpHeaders.authorizationHeader: bearer});
    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = await jsonDecode(response.body);
      print("Json Body :${response.body}");
      final shippingModel = ShippingUpdateModel.fromMap(jsonData);
      return shippingModel.itemsCount;
    }
    return 0;
  }

  Future<List<CartModel>> getCartList() async {
    try {
      List<CartModel> cartList = [];
      final bearer =
          "Bearer ${sharedPreferences.get(AppConstants.JWT_TOKEN_KEY)}";
      print("Token Bearer $bearer");
      final response = await get(
          "https://www.exclusiveinn.com/wp-json/wc/store/cart/",
          headers: {HttpHeaders.authorizationHeader: bearer, HttpHeaders.contentTypeHeader: AppConstants.JSON_CONTENT_TYPE, HttpHeaders.connectionHeader: AppConstants.KEEP_ALIVE,});
      final jsonData = await jsonDecode(response.body);
      print("Json Body :${response.body}");
      final shippingModel = ShippingUpdateModel.fromMap(jsonData);
      print("Json Body2 :${shippingModel.itemsCount}");
      //print("Shipping Model is ${shippingModel.items.first.name}");
      for (ShippingUpdateModelItem item in shippingModel.items) {
        final itemsOfVariations = <Map<String, dynamic>>[];
        for (Variation variant in item.variation) {
          print("Variation: ${variant}");
          itemsOfVariations.add({
            "attribute": variant.attribute,
            "value": variant.value,
          });
        }
        print("Variation ${itemsOfVariations}");
        cartList.add(CartModel(
          itemKey: item.key,
          id: item.id,
          image: item.images != null && item.images.isNotEmpty
              ? item.images.first.thumbnail
              : null,
          name: item.name,
          seller: "Exclusive Inn",
          price: double.parse(item.totals.lineTotal),
          //double.parse(item.prices.price) * item.quantity,
          quantity: item.quantity,
          //variation: item.variation.,
          itemVariations: itemsOfVariations,
          listOfVariation: item.variation.map((e) => e.value).toList(),
          priceSymbol: item.prices.currencyCode,
        ));
      }
      print("Pricing  and length ${cartList.length}");
      totalAmount = 0;
      for (ShippingUpdateModelItem item in shippingModel.items) {
        totalAmount += double.parse(item.totals.lineSubtotal);
        print("Total Amount is $totalAmount");
      }
      List<String> carts =
          sharedPreferences.getStringList(AppConstants.CART_LIST);
      //totalAmount = double.parse(shippingModel.totals.totalPrice);

      //carts.forEach((cart) => cartList.add(CartModel.fromJson(jsonDecode(cart))) );
      return cartList;
    } on StateError catch (e) {
      //throw e;
      print("Error From ${e.stackTrace}");
    }
  }

  getTotal() => totalAmount;
  void addToCartList(List<CartModel> cartProductList) {
    List<String> carts = [];
    cartProductList.forEach((cartModel) => carts.add(jsonEncode(cartModel)));
    // sharedPreferences.setStringList(AppConstants.CART_LIST, carts);
  }

  Future<CartModel> addToCart(CartModel cartModel) async {
    CartModel cart;
    final token = sharedPreferences.get(AppConstants.JWT_TOKEN_KEY);
    final bearerToken = "Bearer $token";
    print("My Bearer Token $bearerToken");
    String jsonDataRaw = """ { "variation":[ """;
    for (int i = 0; i < cartModel.itemVariations.length; i++) {
      if (i < cartModel.itemVariations.length - 1) {
        jsonDataRaw += jsonEncode(cartModel.itemVariations[i]);
        jsonDataRaw += ",";
      } else
        jsonDataRaw += jsonEncode(cartModel.itemVariations[i]);
    }
    jsonDataRaw += """ ]}""";
    print("My JSon Raw DAta is ${jsonDataRaw}");
    final rawData = """  {
     "variation": [
                {
                    "attribute": "Size",
                    "value": "Small"
                },
                {
                    "attribute": "Sleeves",
                    "value": "As Shown in Picture"
                },
                {
                    "attribute": "Lowers",
                    "value": "As Shown in Picture"
                }
                ]
} """;
    final addToCartURL =
        // "https://www.test.exclusiveinn.com/wp-json/wc/store/cart/add-item?id=${cartModel.id}&quantity=${cartModel.quantity}";
        "${AppConstants.ADD_TO_CART_URI2}${cartModel.id}${AppConstants.ADD_TO_CART_URI1}${cartModel.quantity}";
    final xurl =
        "https://www.exclusiveinn.com/wp-json/wc/store/cart/add-item?id=${cartModel.id}&quantity=${cartModel.quantity}";
    print("One URL ${addToCartURL}\nOne URL ${xurl}");

    final cartAdded = await post(addToCartURL,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: bearerToken,
        },
        body: jsonDataRaw);
    print("Check Cart Added ${cartAdded.body}");
    if (cartAdded.statusCode == 200 || cartAdded.statusCode == 201) {
      final cartItem = await jsonDecode(cartAdded.body);
      print(
          "Add To Cart URL ${addToCartURL} and xxBody is ${cartItem["items"]}");
      final carts = CartModel.fromJson(cartItem);
      return carts;
    } else {
      print("Some Error");
      return null;
      //throw Exception("Item was not added to the cart");
    }
  }

  Future<bool> removeCart(String itemKey) async {
    final token = await sharedPreferences.get(AppConstants.JWT_TOKEN_KEY);
    final bearer = "Bearer $token";
    print("Removing Token Bearer. ${bearer}");
    final url = "${AppConstants.REMOVE_CART_URI}$itemKey";
    print("Bearer Token for removing and Item KEy $url");
    final response =
        await post(url, headers: {HttpHeaders.authorizationHeader: bearer});
    print(
        "Response for Removing is ${response.body} and code ${response.statusCode}");
    if (response.statusCode == 200 || response.statusCode == 201) return true;
    return false;
  }
}
