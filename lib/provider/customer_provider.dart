import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:sixvalley_ui_kit/data/model/response/wordpress_customer_model.dart';
import 'package:sixvalley_ui_kit/utill/app_constants.dart';

class CustomerProvider extends ChangeNotifier {
  WordPressCustomerModel _wordPressCustomerModel;

  WordPressCustomerModel get wordPressCustomerModel => _wordPressCustomerModel;
  bool _isFindingCustomer = false;

  bool get isFindingCustomer => _isFindingCustomer;

  set isFindingCustomer(bool value) {
    _isFindingCustomer = value;
    notifyListeners();
  }

  Future<WordPressCustomerModel> initCustomerDetails(int userID) async {
    _wordPressCustomerModel = await fetchCustomerInfo(userID);
    _isFindingCustomer = false;
    notifyListeners();
    return _wordPressCustomerModel;
  }

  Future<WordPressCustomerModel> fetchCustomerInfo(int userId) async {
    print("USer ID IS ${userId}");
    final response = await get("${AppConstants.WP_CUSTOMER_URI}$userId",
        headers: AppConstants.WP_AUTH_HEADER);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print("My Json User $json");
      _wordPressCustomerModel =
          WordPressCustomerModel.fromJson(json["customer"]);
      if (_wordPressCustomerModel.billingAddressModel != null) {
        //ProfileRepo().saveUserAddress(response.body);
        print(
            "My ADdress fetch ${_wordPressCustomerModel.billingAddressModel.address_1}");
        notifyListeners();
        return _wordPressCustomerModel;
      }
    }
    notifyListeners();
    return null;
  }
}

class CustomerRepo {
  WordPressCustomerModel _wordPressCustomerModel;

  WordPressCustomerModel get wordPressCustomerModel => _wordPressCustomerModel;

  Future<WordPressCustomerModel> fetchCustomerInfo(int userId) async {
    print("USer ID IS ${userId}");
    final response = await get("${AppConstants.WP_CUSTOMER_URI}$userId",
        headers: AppConstants.WP_AUTH_HEADER);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print("User Address is ${response.body}");
      _wordPressCustomerModel =
          WordPressCustomerModel.fromJson(json["customer"]);
      if (_wordPressCustomerModel.billingAddressModel != null) {
        //ProfileRepo().saveUserAddress(response.body);
        return _wordPressCustomerModel;
      }
      return null;
    } else {
      print("User is not available");
      return null;
    }
  }
}
