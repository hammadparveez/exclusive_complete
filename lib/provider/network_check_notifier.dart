import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:sixvalley_ui_kit/data/repository/network_notifier_repo.dart';
import 'package:sixvalley_ui_kit/utill/app_constants.dart';

class NetworkCheckNotifier extends ChangeNotifier {
  bool _isNoInternet = false, _isTimedOut = false;
  final NetworkCheckRepo networkCheckRepo;

  NetworkCheckNotifier(this.networkCheckRepo);
  Future<void> checkInternet() async {
    _isTimedOut = false;
    _isNoInternet = false;
    try {
      await networkCheckRepo.checkInternet();
    }on SocketException catch(error) {
      _isNoInternet = true;
    }on TimeoutException catch(error) {
      _isTimedOut = true;
    }
    notifyListeners();
  }

  get isTimedOut => _isTimedOut;

  bool get isNoInternet => _isNoInternet;
}