import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart' as get_it;
import 'package:sixvalley_ui_kit/data/model/response/wordpress_product_model.dart';
import 'package:sixvalley_ui_kit/data/repository/wordpress_products_repo.dart';
import 'package:sixvalley_ui_kit/utill/app_constants.dart';
import 'package:sixvalley_ui_kit/utill/decode_json.dart';

final getInstance = get_it.GetIt.instance;

class WordPressProductProvider extends ChangeNotifier {
  final WordPressProductRepo wordPressProductRepo;
  bool _firstLoading = true;
  bool _isRequestTimedOut = false;
  bool _isNoInternet = false;
  bool get isNoInternet => _isNoInternet;

  set isNoInternet(bool value) {
    _isNoInternet = value;
  }

  bool get isRequestTimedOut => _isRequestTimedOut;

  set isRequestTimedOut(bool value) {
    _isRequestTimedOut = value;
  }

  int categoryTotalCount = 0;
  bool _isLoadingMore = false;

  bool get isLoadingMore => _isLoadingMore;

  set isLoadingMore(bool value) {
    _isLoadingMore = value;
    notifyListeners();
  }

  bool get firstLoading => _firstLoading;
  bool _hasProductsFound = true;
  bool _isLoadingProducts = true;

  bool get isLoadingProducts => _isLoadingProducts;

  set isLoadingProducts(bool value) {
    _isLoadingProducts = value;
    notifyListeners();
  }

  bool get hasProductsFound => _hasProductsFound;

  set hasProductsFound(bool value) {
    _hasProductsFound = value;
    notifyListeners();
  }

  WordPressProductModel _wordPressProductModelByID;
  List<WordPressProductModel> _listOfRelatedProducts = [];
  List<WordPressProductModel> listOfCategoryProducts = [];
  List<WordPressProductModel> listOfFeaturedProducts = [];
  List<WordPressProductModel> listOfRandomProducts = [];

  List<WordPressProductModel> listOfWpProducts = [], stackProductList = [];
  WordPressProductModel _wordPressProductModel;
  final wordPressProducts =
      getInstance.get<Future<List<WordPressProductModel>>>();
  WordPressProductModel _foundProductModel;

  WordPressProductProvider(this.wordPressProductRepo);

  WordPressProductModel get foundProductModel => _foundProductModel;

  WordPressProductModel get wordPressProductModel => _wordPressProductModel;

  Future<void> initFeaturedProducts() async {
    listOfFeaturedProducts = await fetchFeaturedProducts();
    _firstLoading = false;
    notifyListeners();
  }

  resetRelatedProducts() {
    _listOfRelatedProducts = [];
    notifyListeners();
  }

  List<WordPressProductModel> get listOfRelatedProducts =>
      _listOfRelatedProducts;

  set listOfRelatedProducts(List<WordPressProductModel> value) {
    _listOfRelatedProducts = value;
    notifyListeners();
  }

  initRelatedProduct({List<dynamic> listRelatedItems}) async {
    _listOfRelatedProducts =
        await wordPressProductRepo.getRelatedProducts(listRelatedItems);
    print("Provider Related Length ${_listOfRelatedProducts}");
    listOfSubRelatedProducts.add(_listOfRelatedProducts);
    notifyListeners();
  }

  Future<void> initTotalCategoryCounts(String slug) async {
    final int totalCounts =
        await wordPressProductRepo.getTotalCategoryCount(slug);
    categoryTotalCount = totalCounts;
    notifyListeners();
  }

  resetCategoryList() {
    listOfCategoryProducts = [];
    hasProductsFound = false;
    notifyListeners();
  }

  Future<void> initRandomProducts(int pageCount) async {
    final products = await wordPressProductRepo.getRandomProducts(pageCount);
    print("Products Random ${products.length}");
    listOfRandomProducts.addAll(products);
    _isLoadingProducts = false;
    notifyListeners();
  }

  void initBrandAndCategoryProducts({int pageCount = 1, String slug}) async {
    listOfRandomProducts = [];
    print("Number of Page Counts are $pageCount");
    final listOfCategorizedProducts = await wordPressProductRepo
        .initBrandAndCategoryProducts(pageCount, slug);
    print("List Of Categoriez Products ${listOfCategorizedProducts}");

    /*  listOfCategorizedProducts.forEach((element) {
      if (element["variations"].length > 0 && element["in_stock"])
        listOfCategoryProducts.add(WordPressProductModel.fromJson(element));
    });*/
    listOfCategorizedProducts.where((element) {
      if (/*element["variations"].length > 0 &&*/ element["in_stock"])
        listOfCategoryProducts.add(WordPressProductModel.fromJson(element));
      return (element["variations"].length > 0 && element["in_stock"]);
    }).toList();
    _isLoadingMore = false;
    _isLoadingProducts = false;
    notifyListeners();
  }

  resetProduct() {
    _wordPressProductModelByID = null;
    notifyListeners();
  }

  initDetailProduct({@required int productID}) async {
    _isRequestTimedOut = false;
    _isNoInternet = false;
    _wordPressProductModelByID =
        await wordPressProductRepo.iniDetailPage(productID).catchError((e) {
      _isNoInternet = true;
    });
    if (_wordPressProductModelByID != null) {
      stackProductList.add(_wordPressProductModelByID);
    }
    notifyListeners();
  }

  set wordPressProductModelByID(WordPressProductModel value) {
    _wordPressProductModelByID = value;
    notifyListeners();
  }

  List<List<WordPressProductModel>> listOfSubRelatedProducts = [];
  WordPressProductModel get wordPressProductModelByID =>
      _wordPressProductModelByID;

  WordPressProductModel _getWooCommerceProduct() {}

  Future<List<WordPressProductModel>> fetchFeaturedProducts(
      {int limit = 0}) async {
    _isNoInternet = false;
    _isRequestTimedOut = false;
    List<WordPressProductModel> listOfWPFeatureProducts = [];

    //final perf =  .getInstance();
    final featureProducts =
        await wordPressProductRepo.featuredProducts().catchError((error) {
      _isNoInternet = true;
      return [];
    }).timeout(AppConstants.TIMED_OUT_20, onTimeout: () async {
      _isRequestTimedOut = true;
      return [];
    });

    final f = featureProducts;
    f.forEach((element) {
      if (element["in_stock"] && element["variations"].isNotEmpty) {
        listOfWPFeatureProducts.add(WordPressProductModel.fromJson(element));
      }
    });

/*
      print("Products with Features ${products.first}");
      //final List<dynamic> allProducts = products["products"];
      final List<WordPressProductModel> featuredProducts = [];
      products.forEach((product) {
        featuredProducts.add(product);
  */ /*      wpPros.forEach((elpement) {
          if (product["id"] == element.id) {
            print("Adding PRoducts");
            featuredProducts.add(element);
          }
        });*/ /*
      });
      print("Check Length ${featuredProducts.length}");*/
    return listOfWPFeatureProducts;

    //throw AssertionError("Cannot fetch products");
  }

  void searchProducts() async {
    final List<WordPressProductModel> products = await wordPressProducts;
  }

  Future<WordPressProductModel> findProductById(int productId) async {
    String body;
    //if(perfren)
    final List<WordPressProductModel> products =
        await DecodeToJson.decodeFromJsonOrUrl();
    WordPressProductModel product;
    if (products != null) {
      product = products.firstWhere((product) => product.id == productId);
      _foundProductModel = product;
      print("Product is found successfully ${product}");
    }
    notifyListeners();
    return product;
    //products.firstWhere()
  }
}
