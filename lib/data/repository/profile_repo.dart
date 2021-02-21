import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_ui_kit/data/model/payment_gateway_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/user_info_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/wordpress_customer_model.dart';
import 'package:sixvalley_ui_kit/data/repository/billing_address_repo.dart';
import 'package:sixvalley_ui_kit/data/shipping_update_model.dart';
import 'package:sixvalley_ui_kit/provider/customer_provider.dart';
import 'package:sixvalley_ui_kit/utill/app_constants.dart';

class ProfileRepo {
  final SharedPreferences sharedPreferences;
  final CustomerRepo customerRepo;
  ProfileRepo({@required this.sharedPreferences, this.customerRepo});

  List<String> getAddressTypeList() {
    List<String> addressTypeList = [
      'Select Address type',
      'Home',
      'Office',
      'Other',
    ];
    return addressTypeList;
  }

  Future<BillingAddressModel> fetchUserAddress() async {
    if (sharedPreferences.containsKey(AppConstants.WP_USER_ID)) {
      final userID = sharedPreferences.get(AppConstants.WP_USER_ID);
      final WordPressCustomerModel model =
          await customerRepo.fetchCustomerInfo(userID);
      if (model != null) return model.billingAddressModel;
    }
    return null;
  }

  UserInfoModel getUserInfo() {
    UserInfoModel userInfoModel = UserInfoModel(
        id: 1,
        name: 'John Doe',
        fName: 'John',
        lName: 'Doe',
        phone: '+886737663',
        email: 'johndoe@gmail.com',
        image: 'assets/images/person.jpg');
    return userInfoModel;
  }

  BillingAddressModel saveUserAddress() {
    final isContained =
        sharedPreferences.containsKey(AppConstants.ADD_ADDRESS_URI);
    String body;
    if (isContained) {
      body = sharedPreferences.get(AppConstants.ADD_ADDRESS_URI);
    }
  }

  List<BillingAddressModel> getAllAddress() {
    final addressRepo = GetIt.instance.get<BillingAddressRepo>();
    //addressRepo.billingAddressModel;
    List<BillingAddressModel> addressList = [
      addressRepo.billingAddressModel,
      /*  AddressModel(
          id: 1,
          customerId: '1',
          contactPersonName: 'John Doe',
          addressType: 'Home',
          address: 'Dhaka, Bangladesh'),*/
    ];
    return addressList;
  }

  updateShipping({String countryCode}) async {
    print("Shipping called");
    try {
      final toke = sharedPreferences.get(AppConstants.JWT_TOKEN_KEY);
      print("Shipping Token $toke");
      final header = "Bearer $toke";
      print("\n\n ${header}\n\n");
      if (countryCode != null) {
        final response = await post(
            AppConstants.UPDATE_SHIPPING_URI + "${countryCode.toLowerCase()}",
            headers: {
              //HttpHeaders.contentTypeHeader: "application/json",
              HttpHeaders.authorizationHeader: header,
            });
        print("Status Code ${response.statusCode}");
        print("Converted Data ${response.body}");
        if (response.statusCode == 200 || response.statusCode == 201) {
          print("Converted Data ${response.body}");
          final data = await jsonDecode(response.body);
          if (data != null) {
            final c = ShippingUpdateModel.fromMap(data);
            print(
                "Welcomed Data ${c.items} and ${c.shippingAddress.firstName}");

            return ShippingUpdateModel.fromMap(data);
          }
          return null;
        }
      }
    } catch (error) {
      print("Update Shipping Error $error");
      return null;
    }
    return null;
  }

  // for save home address
  Future<void> saveHomeAddress(String homeAddress) async {
    try {
      await sharedPreferences.setString(AppConstants.HOME_ADDRESS, homeAddress);
    } catch (e) {
      throw e;
    }
  }

  String getHomeAddress() {
    return sharedPreferences.getString(AppConstants.HOME_ADDRESS) ?? "";
  }

  Future<bool> clearHomeAddress() async {
    return sharedPreferences.remove(AppConstants.HOME_ADDRESS);
  }

  // for save office address
  Future<void> saveOfficeAddress(String officeAddress) async {
    try {
      await sharedPreferences.setString(
          AppConstants.OFFICE_ADDRESS, officeAddress);
    } catch (e) {
      throw e;
    }
  }

  String getOfficeAddress() {
    return sharedPreferences.getString(AppConstants.OFFICE_ADDRESS) ?? "";
  }

  Future<bool> clearOfficeAddress() async {
    return sharedPreferences.remove(AppConstants.OFFICE_ADDRESS);
  }

  Future<List<PaymentGateway>> fetchPaymentGateways() async {
    List<PaymentGateway> paymentGateways = [];
    final bearer = AppConstants.JWT_ADMIN_TOKEN;
    final response = await get(AppConstants.WP_PAYMENT_GATEWAYS_URI,
        headers: {HttpHeaders.authorizationHeader: bearer});
    print("PaymentGateways: ${response.body}");
    if (response.statusCode == 201 || response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print("Decode Payments $json");
      final jsonAsList = json as List;
      jsonAsList.forEach((element) {
        paymentGateways.add(PaymentGateway.fromMap(element));
      });
      return paymentGateways;
    } else {
      return [];
    }
  }
}
