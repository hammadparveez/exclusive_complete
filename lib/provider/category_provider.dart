import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/response/category.dart';
import 'package:sixvalley_ui_kit/data/repository/category_repo.dart';
import 'package:sixvalley_ui_kit/utill/app_constants.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryRepo categoryRepo;
  bool _isInternet = false;

  bool get isInternet => _isInternet;

  set isInternet(bool value) {
    _isInternet = value;
  }

  bool _isTimedOut = false;
  CategoryProvider({@required this.categoryRepo});

  List<Category> _categoryList = [];
  int _categorySelectedIndex;
  List<Category> allCategories = [];
  List<Category> get categoryList => _categoryList;
  String _selectedCategorySlug;

  String get selectedCategorySlug => _selectedCategorySlug;

  set selectedCategorySlug(String value) {
    _selectedCategorySlug = value;
    notifyListeners();
  }

  int get categorySelectedIndex => _categorySelectedIndex;

  Future<void> initCategoryList() async {
    _isTimedOut = false;
    _isInternet = false;
    _categoryList = await categoryRepo.getCategoryList()
        .catchError((error) { _isInternet = true;  return <Category>[];})
        .timeout(AppConstants.TIMED_OUT_20, onTimeout: () async {_isTimedOut = true; return <Category>[];}) ;
    print("Cateeeee ${_categoryList.length}");
    allCategories = categoryRepo.allCategory;

    _categorySelectedIndex = 0;
    notifyListeners();
    //}
  }

  void getAllCategories() {
    allCategories = categoryRepo.allCategory;
    notifyListeners();
  }

  void changeSelectedIndex(int selectedIndex) {
    _categorySelectedIndex = selectedIndex;
    notifyListeners();
  }

  bool get isTimedOut => _isTimedOut;

  set isTimedOut(bool value) {
    _isTimedOut = value;
  }
}
