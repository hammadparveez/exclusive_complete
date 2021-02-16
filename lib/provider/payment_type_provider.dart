import 'package:flutter/cupertino.dart';

class PaymentTypeProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }

  int get selectedIndex => _selectedIndex;
}
