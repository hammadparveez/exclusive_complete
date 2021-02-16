import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/response/category.dart';
import 'package:sixvalley_ui_kit/data/repository/category_repo.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryRepo categoryRepo;

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

  void initCategoryList() async {
    /*if (_categoryList.length == 0) {
      _categoryList.clear();*/
    _categoryList = await categoryRepo.getCategoryList();
    print("Cateeeee ${_categoryList.length}");
    allCategories = categoryRepo.allCategory;
    /*_categoryList.forEach((element) {
        print("Initializing Categories ${element.name} ");
      });*/

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
}
