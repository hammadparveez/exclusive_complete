import 'package:flutter/foundation.dart';
import 'package:sixvalley_ui_kit/data/model/response/wordpress_product_model.dart';

class StackProvider extends ChangeNotifier {
  final List<WordPressProductModel> _stack = [];

  List<WordPressProductModel> get stack => _stack;

  addToStack(WordPressProductModel model) {
    _stack.add(model);
    notifyListeners();
  }

  removeFromStack() {
    _stack.removeLast();
    notifyListeners();
  }
}
