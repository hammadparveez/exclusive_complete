import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/response/product_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/wp_product_model.dart';
import 'package:sixvalley_ui_kit/data/repository/product_repo.dart';
import 'package:sixvalley_ui_kit/data/repository/wp_repo.dart';

class ProductProvider extends ChangeNotifier {
  final ProductRepo productRepo;
  ProductProvider({@required this.productRepo});
  final WpProductModel wpProductModel = WpProductModel();
  final WordPressRepo wordPressRepo = WordPressRepo();
  // Latest products
  List<Product> _latestProductList = [];
  List<WpProductModel> _listOfLatestProduct = [];

  List<WpProductModel> get listOfLatestProduct => _listOfLatestProduct;
  bool _firstLoading = true;

  List<Product> get latestProductList => _latestProductList;
  bool get firstLoading => _firstLoading;

  void initLatestProductList() async {
    _latestProductList = [];
    //_latestProductList.addAll(productRepo.getLatestProductList());
    //final product = await wordPressRepo.getProducts();
    //_listOfLatestProduct.addAll(product);
    //_firstLoading = false;
    notifyListeners();
  }

  void removeFirstLoading() {
    _firstLoading = true;
    notifyListeners();
  }

  // Seller products
  List<Product> _sellerAllProductList = [];
  List<Product> _sellerProductList = [];
  List<Product> get sellerProductList => _sellerProductList;

  void initSellerProductList() async {
    _firstLoading = false;
    _sellerProductList.addAll(productRepo.getSellerProductList());
    _sellerAllProductList.addAll(productRepo.getSellerProductList());
    notifyListeners();
  }

  void filterData(String newText) {
    _sellerProductList.clear();
    if (newText.isNotEmpty) {
      _sellerAllProductList.forEach((product) {
        if (product.name.toLowerCase().contains(newText.toLowerCase())) {
          _sellerProductList.add(product);
        }
      });
    } else {
      _sellerProductList.clear();
      _sellerProductList.addAll(_sellerAllProductList);
    }
    notifyListeners();
  }

  void clearSellerData() {
    _sellerProductList = [];
    notifyListeners();
  }

  // Brand and category products
  List<WpProductModel> _brandOrCategoryProductList = [];
  bool _hasData = false;

  List<WpProductModel> get brandOrCategoryProductList =>
      _brandOrCategoryProductList;
  bool get hasData => _hasData;

  void initBrandOrCategoryProductList(bool isBrand, String id,
      {String categoryName}) async {
    _brandOrCategoryProductList.clear();
    _hasData = true;
    _brandOrCategoryProductList = await wordPressRepo.getProducts();
    /*final List<WpProductModel> _listOfLatestProduct = await productRepo
        .getBrandOrCategoryProductList(categoryName: categoryName);
    productList.forEach((product) => _brandOrCategoryProductList.add(product));*/
    _hasData = _brandOrCategoryProductList.length > 1;

    notifyListeners();
  }

  // Related products
  List<Product> _relatedProductList;
  List<Product> get relatedProductList => _relatedProductList;

  void initRelatedProductList() async {
    _firstLoading = false;
    _relatedProductList = [];
    productRepo
        .getRelatedProductList()
        .forEach((product) => _relatedProductList.add(product));
    notifyListeners();
  }

  void removePrevRelatedProduct() {
    _relatedProductList = null;
    notifyListeners();
  }
}
