import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/response/wordpress_product_model.dart';
import 'package:sixvalley_ui_kit/data/repository/search_repo.dart';

class SearchProvider with ChangeNotifier {
  final SearchRepo searchRepo;
  SearchProvider({@required this.searchRepo});

  int _filterIndex = 0;

  int get filterIndex => _filterIndex;

  void setFilterIndex(int index) {
    _filterIndex = index;
    notifyListeners();
  }

/*  void sortSearchList(double startingPrice, double endingPrice) {
    if (_filterIndex == 0) {
      _searchProductList.clear();
      _searchProductList.addAll(_filterProductList);
    } else if (_filterIndex == 1) {
      _searchProductList.clear();
      if(startingPrice > 0 && endingPrice > startingPrice) {
        _searchProductList.addAll(_filterProductList.where((product) =>
        (double.parse(product.unitPrice)) > startingPrice && (double.parse(product.unitPrice)) < endingPrice).toList());
      }else {
        _searchProductList.addAll(_filterProductList);
      }
      _searchProductList.sort((a, b) => a.name.compareTo(b.name));
    } else if (_filterIndex == 2) {
      _searchProductList.clear();
      if(startingPrice > 0 && endingPrice > startingPrice) {
        _searchProductList.addAll(_filterProductList.where((product) =>
        (double.parse(product.unitPrice)) > startingPrice && (double.parse(product.unitPrice)) < endingPrice).toList());
      }else {
        _searchProductList.addAll(_filterProductList);
      }
      _searchProductList.sort((a, b) => a.name.compareTo(b.name));
      Iterable iterable = _searchProductList.reversed;
      _searchProductList = iterable.toList();
    } else if (_filterIndex == 3) {
      _searchProductList.clear();
      if(startingPrice > 0 && endingPrice > startingPrice) {
        _searchProductList.addAll(_filterProductList.where((product) =>
        (double.parse(product.unitPrice)) > startingPrice && (double.parse(product.unitPrice)) < endingPrice).toList());
      }else {
        _searchProductList.addAll(_filterProductList);
      }
      _searchProductList.sort((a, b) => double.parse(a.unitPrice).compareTo(double.parse(b.unitPrice)));
    } else if (_filterIndex == 4) {
      _searchProductList.clear();
      if(startingPrice > 0 && endingPrice > startingPrice) {
        _searchProductList.addAll(_filterProductList.where((product) =>
        (double.parse(product.unitPrice)) > startingPrice && (double.parse(product.unitPrice)) < endingPrice).toList());
      }else {
        _searchProductList.addAll(_filterProductList);
      }
      _searchProductList.sort((a, b) => a.unitPrice.compareTo(b.unitPrice));
      Iterable iterable = _searchProductList.reversed;
      _searchProductList = iterable.toList();
    }

    notifyListeners();
  }*/

  /* List<Product> _searchProductList;
  List<Product> _filterProductList;*/
  List<WordPressProductModel> _searchProductList = [];
  List<WordPressProductModel> _filterProductList;
  bool _isClear = true;
  bool _isAllProductsFetched = false;

  bool get isAllProductsFetched => _isAllProductsFetched;

  bool _isLoadingProducts = false;
  bool _onScrollLoader = false;

  bool get onScrollLoader => _onScrollLoader;

  bool get isLoadingProducts => _isLoadingProducts;

  String _searchText = '';

  /*List<Product> get searchProductList => _searchProductList;
  List<Product> get filterProductList => _filterProductList;*/
  List<WordPressProductModel> get searchProductList => _searchProductList;
  List<WordPressProductModel> get filterProductList => _filterProductList;

  bool get isClear => _isClear;
  String get searchText => _searchText;

  void setSearchText(String text) {
    _searchText = text;
    notifyListeners();
  }

  void scrollerLoading() {
    _onScrollLoader = true;
    print("Scroll laoding called ");
    notifyListeners();
  }

  void loadingProducts() {
    _isLoadingProducts = true;
    notifyListeners();
  }

  void cleanSearchProduct() {
    _searchProductList = [];
    _isAllProductsFetched = false;
    _isClear = true;
    _searchText = '';
    notifyListeners();
  }

  void searchProduct(String query, int pageCount) async {
    _searchText = query;

    print(
        "My Query which was entered $query and $pageCount and Length is ${searchProductList.length}");
    _isClear = false;
    //_searchProductList = null;
    _filterProductList = null;
    //_searchProductList = [];
    final wordPressSearchedProducts =
        await searchRepo.getSearchProductList(query, pageCount);
    print(
        "My List Fetch ${isAllProductsFetched} ${wordPressSearchedProducts.length}");
    if (wordPressSearchedProducts.isNotEmpty) {
      _searchProductList.addAll(wordPressSearchedProducts);
      _isLoadingProducts = false;
    } else {
      print("Wordpress search ${wordPressSearchedProducts.length}");
      _isAllProductsFetched = true;
      _isLoadingProducts = false;
    }
    _onScrollLoader = false;

    if (query.isEmpty) {
      _searchProductList = [];
    } else {
      //_searchProductList = [];
      //_searchProductList.addAll(await searchRepo.getSearchProductList(query));
      _filterProductList = [];
      //_filterProductList.addAll(await searchRepo.getSearchProductList(query));
    }
    notifyListeners();
  }

  // for save home address
  void saveSearchAddress(String searchAddress) async {
    searchRepo.saveSearchAddress(searchAddress);
  }

  List<String> getSearchAddress() {
    return searchRepo.getSearchAddress();
  }

  Future<bool> clearSearchAddress() async {
    return searchRepo.clearSearchAddress();
  }
}
