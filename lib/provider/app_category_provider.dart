import 'package:flutter/foundation.dart';

class AppCategoriesProvider extends ChangeNotifier {}

extension Capitalization on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  String get allInCaps => this.toUpperCase();
  String get allWordsCapitilize {
    return this.toLowerCase().split(' ').map((word) {
      String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
      return word[0].toUpperCase() + leftText;
    }).join(' ');
  }
}
