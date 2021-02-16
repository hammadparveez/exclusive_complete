import 'package:flutter/cupertino.dart';

class TestProvider extends ChangeNotifier {
  init() {
    print("Hello World");
    notifyListeners();
  }
}
