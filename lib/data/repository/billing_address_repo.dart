import 'dart:convert';
import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_ui_kit/data/model/response/address_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/wordpress_customer_model.dart';
import 'package:sixvalley_ui_kit/utill/app_constants.dart';

import 'auth_repo.dart';

class BillingAddressRepo {
  BillingAddressModel _billingAddressModel;

  BillingAddressModel get billingAddressModel => _billingAddressModel;

  Future<BillingAddressModel> updateBillingAddress({
    String firstName,
    String lastName,
    String addr1,
    String addr2,
    String city,
    String zipCode,
    String country,
    String state,
    String phoneNo,
  }) async {
    final userRepo = GetIt.instance.get<AuthRepo>();
    final id = userRepo.getUserID();
    print("Address user ID ${id}");
    String rawBody =
        '{"billing":{"first_name":"$firstName","last_name":"$lastName","company":"","address_1":"$addr1","address_2":"$addr2","city":"$city","postcode":"$zipCode","country":"$country","state":"$state","email":"john.doe@example.com","phone":"$phoneNo"}, "shipping":{"first_name":"$firstName","last_name":"$lastName","company":"","address_1":"$addr1","address_2":"$addr2","city":"$city","postcode":"$zipCode","country":"$country","state":"$state","email":"john.doe@example.com"}}';
    final response = await http.put(
        AppConstants.CUSTOMER_URI_WITH_ADDR + "${id}",
        body: rawBody,
        headers: {
          "Accept": "application/json",
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: AppConstants.JWT_ADMIN_TOKEN,
          HttpHeaders.connectionHeader: AppConstants.KEEP_ALIVE,
        });
    final json = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      _billingAddressModel = BillingAddressModel.fromJson(json["billing"]);
      print("Billing Data Address ${_billingAddressModel}");
      return _billingAddressModel;
    }
  }

  fetchCountries() {}

  Future<Map<String, dynamic>> getRegions() async {
    final List<CountryModel> countryModel = [];
    String body;
    final perfs = GetIt.instance.get<SharedPreferences>();
    if (perfs.containsKey(AppConstants.REGION_KEY)) {
      // body = perfs.getString(AppConstants.REGION_KEY);
    }
    /*  final jsonData = await DecodeToJson.decodeFromJsonOrUrl(
      //key: AppConstants.REGION_KEY,
      url: AppConstants.COUNTRIES_API_URI,
      callback: http.get,
      // body: body
    );*/
    final jsonData = await http.get(AppConstants.COUNTRIES_API_URI);
    print("${jsonData.body} From JSON Countries and ${jsonData.statusCode}");
    final json = await jsonDecode(jsonData.body);
    final Map<String, dynamic> listOfCountries = json["country"];

    return listOfCountries;
  }

  Future<List<CountryMethodModel>> getRegionMethod(int countryId) async {
    List<CountryMethodModel> countryMethodsModel = [];
    final response = await http.get(
        AppConstants.REGION_URI +
            '$countryId' +
            AppConstants.REGION_METHODS_URI,
        headers: AppConstants.WP_AUTH_HEADER);
    if (response.statusCode == 200) {
      final List listOfMethods = await jsonDecode(response.body);
      listOfMethods.forEach((element) {
        countryMethodsModel.add(CountryMethodModel.fromJson(element));
      });
    } else {
      print("Something is wrong with the Status ");
    }
    return countryMethodsModel;
  }
}
