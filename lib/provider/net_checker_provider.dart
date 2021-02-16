import 'package:flutter/cupertino.dart';
import 'package:sixvalley_ui_kit/data/repository/check_internet_repo.dart';

class InternetCheckerProvider extends ChangeNotifier {
  final InternetCheckRepo internetCheckRepo;
  bool _isInternetOkay = false;

  bool get isInternetOkay => _isInternetOkay;

  set isInternetOkay(bool value) {
    _isInternetOkay = value;
    notifyListeners();
  }

  InternetCheckerProvider(this.internetCheckRepo);
  Future<void> checkInternet() async {
    _isInternetOkay = await internetCheckRepo.checkInternet();
    notifyListeners();
  }
}
