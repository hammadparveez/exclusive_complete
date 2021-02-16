import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/response/config_model.dart';
import 'package:sixvalley_ui_kit/data/repository/splash_repo.dart';

class SplashProvider extends ChangeNotifier {
  final SplashRepo splashRepo;
  SplashProvider({@required this.splashRepo});

  ConfigModel _configModel;
  CurrencyList _currency;
  List<String> _languageList;
  int _currencyIndex = 0;
  int _languageIndex = 0;

  ConfigModel get configModel => _configModel;
  CurrencyList get currency => _currency;
  List<String> get languageList => _languageList;
  int get currencyIndex => _currencyIndex;
  int get languageIndex => _languageIndex;

  Future<bool> initConfig() {
    _configModel = splashRepo.getConfig();
    getCurrencyData(splashRepo.getCurrency());
    _languageList = splashRepo.getLanguageList();
    notifyListeners();
    return Future.value(true);
  }

  void getCurrencyData(String currencyCode) {
    _configModel.currencyList.forEach((currency) {
      if(currencyCode == currency.code) {
        _currency = currency;
        return;
      }
    });
  }

  void setCurrency(String currencyCode) {
    splashRepo.setCurrency(currencyCode);
    getCurrencyData(currencyCode);
    notifyListeners();
  }

  void setCurrencyIndex(int index) {
    _currencyIndex = index;
    setCurrency(_configModel.currencyList[index].code);
    notifyListeners();
  }

  void setLanguageIndex(int index) {
    _languageIndex = index;
  }

  void initSharedPrefData() {
    splashRepo.initSharedData();
  }
}
