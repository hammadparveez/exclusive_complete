import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_ui_kit/data/model/response/product_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/wordpress_product_model.dart';
import 'package:sixvalley_ui_kit/data/repository/wishlist_repo.dart';
import 'package:sixvalley_ui_kit/utill/app_constants.dart';

class WishListProvider extends ChangeNotifier {
  final WishListRepo wishListRepo;
  WishListProvider({@required this.wishListRepo});
  final perfs = GetIt.instance.get<SharedPreferences>();
  bool _wish = false;
  String _searchText = "";

  bool get isWish => _wish;
  String get searchText => _searchText;

  clearSearchText() {
    _searchText = '';
    notifyListeners();
  }

  //List<Product> _wishList = [];
  //List<Product> _allWishList = [];
  List<WordPressProductModel> _wishList = [];
  List<WordPressProductModel> _allWishList = [];
  List<WordPressProductModel> _wishListWordPressProductModel = [];
  List<WordPressProductModel> get wishListWordPressProductModel =>
      _wishListWordPressProductModel;

  //List<Product> get wishList => _wishList;
  //List<Product> get allWishList => _allWishList;
  List<WordPressProductModel> get wishList => _wishList;
  List<WordPressProductModel> get allWishList => _allWishList;
  void searchWishList(String query) async {
    _wishList = [];
    _searchText = query;

    if (query.isNotEmpty) {
      List<WordPressProductModel> products = _allWishList.where((product) {
        return true; //product?.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
      _wishList.addAll(products);
    } else {
      _wishList.addAll(_allWishList);
    }
    notifyListeners();
  }

  void addWishList(Product product,
      {Function feedbackMessage,
      WordPressProductModel wordPressProductModel}) async {
    List<String> toStringWishList = [];
    String message = 'Item successfully added';
    _wishList.add(wordPressProductModel);
    toStringWishList.add(jsonEncode(wordPressProductModel));
    perfs.setStringList(AppConstants.WISH_LIST_KEY, toStringWishList);
    _allWishList.add(wordPressProductModel);
    feedbackMessage(message);
    _wish = true;
    notifyListeners();
  }

  void removeWishList(Product product,
      {int index,
      Function feedbackMessage,
      WordPressProductModel wordPressProductModel}) {
    String message = 'Item successfully removed';
    feedbackMessage(message);
    _wishList.remove(product);
    _allWishList.remove(product);
    _wish = false;
    notifyListeners();
  }

  void checkWishList(String productId) {
    List<String> productIdList = [];
    _allWishList.forEach((wishList) {
      productIdList.add(wishList.id.toString());
    });
    productIdList.contains(productId) ? _wish = true : _wish = false;
    notifyListeners();
  }
}
