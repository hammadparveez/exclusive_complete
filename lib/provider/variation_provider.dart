import 'package:flutter/foundation.dart';
import 'package:sixvalley_ui_kit/data/repository/variation_repo.dart';

class VariationProvider extends ChangeNotifier {
  VariationRepo<String> _variationRepo = VariationRepo<String>();
  //int _value;
  //int get value => _value;
  String _selectedValue;
  int _selectedIndex;

  String get selectedValue => _selectedValue;
  int _counter = 0;

  int get counter => _counter;

  int get selectedIndex => _selectedIndex;

  void setSelectedValue(String value, {int index}) {
    _selectedValue = value;
    _selectedIndex = index;
    _counter++;
    notifyListeners();
  }

  incrementCounter() {
    _counter++;
    notifyListeners();
  }

  clearCounter() {
    _counter = 0;
    notifyListeners();
  }
}
