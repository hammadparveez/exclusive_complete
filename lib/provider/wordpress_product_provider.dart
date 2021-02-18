import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart' as get_it;
import 'package:http/http.dart';
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

  WordPressProductModel wordPressProductModelByID;
  List<WordPressProductModel> listOfRelatedProducts = [];
  List<WordPressProductModel> listOfCategoryProducts = [];
  List<WordPressProductModel> listOfFeaturedProducts = [];
  List<WordPressProductModel> listOfRandomProducts = [];

  List<WordPressProductModel> listOfWpProducts = [];
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
    listOfRelatedProducts = [];
    notifyListeners();
  }

  initRelatedProduct({List<dynamic> listRelatedItems}) async {

    listOfRelatedProducts =  await wordPressProductRepo.getRelatedProducts(listRelatedItems);

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
    print("List Of Categoriez Products ${listOfCategorizedProducts.length}");

    listOfCategorizedProducts.forEach((element) {
      print("Elements are ${element["variations"].length > 0}");
      if (element["variations"].length > 0 && element["in_stock"])
        listOfCategoryProducts.add(WordPressProductModel.fromJson(element));
    });
    listOfCategoryProducts.forEach((element) {
      element.variations.forEach((element) {
        print(
            "Prices are : ${element.price} and ${element.regular_price} $slug");
      });
    });
    _isLoadingMore = false;
    _isLoadingProducts = false;
    notifyListeners();
  }

  resetProduct() {
    wordPressProductModelByID = null;
    notifyListeners();
  }

  initDetailProduct({@required int productID}) async {
    _isRequestTimedOut = false;
    _isNoInternet = false;
    final product =
        await wordPressProductRepo.iniDetailPage(productID).catchError((e) {
      _isNoInternet = true;
    }).timeout(AppConstants.TIMED_OUT_20, onTimeout: () {
      _isRequestTimedOut = true;
    });
    if (!(product is bool))  {
      wordPressProductModelByID = product;
    }
    notifyListeners();
  }

  WordPressProductModel _getWooCommerceProduct() {}

  Future<List<WordPressProductModel>> fetchFeaturedProducts(
      {int limit = 0}) async {

    _isNoInternet = false;
    _isRequestTimedOut = false;
    List<WordPressProductModel> listOfWPFeatureProducts = [];
    //final perf =  .getInstance();
    final featureProducts = await wordPressProductRepo.featuredProducts().catchError((error) {
      _isNoInternet = true;
      return [];
    }).timeout(AppConstants.TIMED_OUT_20, onTimeout: () async { _isRequestTimedOut= true; return [];});

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
  */ /*      wpPros.forEach((element) {
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
