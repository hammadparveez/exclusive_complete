import 'dart:async';
import 'dart:io';

import 'package:http/http.dart';
import 'package:sixvalley_ui_kit/utill/app_constants.dart';

class NetworkCheckRepo {
  bool _isNoInternet = false, _isTimedOut = false;
  Future<bool> checkInternet() async {

    final res = await get(AppConstants.NETWORK_URI).catchError((error) {
      throw SocketException("Socket Exception");
    }).timeout(AppConstants.TIMED_OUT_20, onTimeout: () async {
      throw TimeoutException("Timed out");
    });
    if(res != null && res.statusCode == 200)
      return true;
    return false;
  }
}